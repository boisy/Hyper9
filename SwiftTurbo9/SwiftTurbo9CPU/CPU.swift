import Foundation

enum RegisterType {
    case eightBit
    case sixteenBit
}

enum Register {
    case A
    case B
    case D
    case X
    case Y
    case U
    case SP
    case DP
    case CC
    case PC

    var type: RegisterType {
        switch self {
        case .A, .B, .DP, .CC:
            return .eightBit
        case .D, .X, .Y, .U, .SP, .PC:
            return .sixteenBit
        }
    }
    
    static func registerMapping(_ reg : Int) -> Register {
        switch reg {
        case 0:
            return .D
        case 1:
            return .X
        case 2:
            return .Y
        case 3:
            return .U
        case 4:
            return .SP
        case 5:
            return .PC
        case 8:
            return .A
        case 9:
            return .B
        case 10:
            return .CC
        case 11:
            return .DP
        default:
            return .D
        }
    }
}

class CPU : ObservableObject {
    /// The 16-bit program counter PC.
    @Published var PC: UInt16 = 0x0000
    
    /// The 16-bit  system stack pointer S.
    @Published var S: UInt16 = 0x00FF
    
    /// The 8-bit accumulator `A`.
    @Published var A: UInt8 = 0x00
    
    /// The 8-bit accumulator `B`.
    @Published var B: UInt8 = 0x00
    
    /// The 16-bit accumulator D.
    ///
    /// D is the concatentation of accumulators A and B.
    var D: UInt16 {
        get {
            return UInt16(A) << 8 | UInt16(B)
        }
        set {
            A = UInt8(newValue >> 8)
            B = UInt8(newValue & 0xFF)
        }
    }
    
    var memoryDump: String {
        self.bus.ramDump(address: 0, numBytes: 256)
    }
    
    /// The 16-bit index register `X`.
    @Published var X: UInt16 = 0x00
    
    /// The 16-bit index register `Y`.
    @Published var Y: UInt16 = 0x00
    
    /// The 16-bit user stack pointer Y.
    @Published var U: UInt16 = 0x0000
    
    /// The 8-bit direct page register `DP`.
    @Published var DP: UInt8 = 0x00
    
    /// The 8-bit condition code register `CC`.
    @Published var CC: UInt8 = 0x00
    var clockCycles: Int = 0
    
    /// The string respresentation of the register `CC`.
    var ccString : String {
        get {
            var states = ""
            if readCC(.entire) == true { states += "E"}
            else { states += "-" }
            if readCC(.firq) == true { states += "F" }
            else { states += "-" }
            if readCC(.halfcarry) == true { states += "H" }
            else { states += "-" }
            if readCC(.irq) == true { states += "I" }
            else { states += "-" }
            if readCC(.negative) == true { states += "N" }
            else { states += "-" }
            if readCC(.zero) == true { states += "Z" }
            else { states += "-" }
            if readCC(.overflow) == true { states += "O" }
            else { states += "-" }
            if readCC(.carry) == true { states += "C" }
            else { states += "-" }
            
            return states
        }
        set {
        }
    }
    
    /// A pointer to the address where an instruction reads or writes a value, or branches to.
    var addressAbsolute: UInt16 = 0x0000
    
    /// A flag that tindicates whether to show instructions as they execute.
    var debug : Bool = true
    
    // MARK: - Private properties
    
    let bus: Bus
    
    // MARK: - Init
    
    init(
        bus: Bus = Bus(),
        pc: UInt16 = 0x0000,
        stackPointer: UInt16 = 0xFF,
        A: UInt8 = 0x00,
        B: UInt8 = 0x00,
        X: UInt16 = 0x00,
        Y: UInt16 = 0x00,
        U: UInt16 = 0x00,
        DP: UInt8 = 0x00,
        flags: UInt8 = 0x00
    ) {
        self.bus = bus
        self.PC = pc
        self.S = stackPointer
        self.A = A
        self.B = B
        self.X = X
        self.Y = Y
        self.U = U
        self.DP = DP
        self.CC = flags
        
        // Initialize Turbo9 SWI3 vector
        writeWord(0xFFF2, data: 0x0100)
        
        // Initialize Turbo9 SWI2 vector
        writeWord(0xFFF4, data: 0x0100)
        
        // Initialize Turbo9 FIRQ vector
        writeWord(0xFFF6, data: 0x0100)
        
        // Initialize Turbo9 IRQ vector
        writeWord(0xFFF8, data: 0x0100)
        
        // Initialize Turbo9 SWI vector
        writeWord(0xFFFA, data: 0x0100)
        
        // Initialize Turbo9 NMI vector
        writeWord(0xFFFC, data: 0x0100)
        
        // Initialize Turbo9 RESET vector
        writeWord(0xFFFE, data: 0x0000)
    }
    
    /// Reset the CPU.
    func reset() throws {
        // Fetch the address at the reset vector
        let addr = readWord(0xFFFE)
        A = 0
        B = 0
        X = 0
        Y = 0
        U = 0
        S = 0
        DP = 0
        CC = 0
        PC = addr
    }

    func continueExection(to: UInt16) throws {
        while PC != to {
            try step()
        }
    }
    
    func step(count: Int = 1) throws {
        for _ in 0..<count {
            var opcode : OpCode
            let opcodeByte = readByte(PC)
            PC = PC &+ 1
            
            if opcodeByte != 0x00 {
                if opcodeByte == 0x10 {
                    let opcodeByte = readByte(PC)
                    opcode = Self.opcodes10[Int(opcodeByte)]
                    PC = PC &+ 1
                } else if opcodeByte == 0x11 {
                    let opcodeByte = readByte(PC)
                    opcode = Self.opcodes11[Int(opcodeByte)]
                    PC = PC &+ 1
                } else {
                    opcode = Self.opcodes[Int(opcodeByte)]
                }
                
                let extraClockCycles = setupAddressing(using: opcode.1)
                let shouldIncludeExtraClockCycles = try perform(instruction: opcode.0, addressMode: opcode.1)
                
                // Increase clock cycles and add extra cycles, if needed.
                // Extra cycles usually happens if a page boundry was crossed.
                clockCycles += opcode.2 + (shouldIncludeExtraClockCycles ? extraClockCycles : 0)
            }
        }
    }
    
    /// Start a program.
    func run(count : UInt = UInt.max) throws {
        var counter = count
        if count == UInt.max {
            while true {
                try step()
            }
        } else {
            while (counter > 0) {
                try step()
                counter = counter - 1
            }
        }
    }
    
    // MARK: - Communicate with bus
    
    /// Read a single byte from memory.
    /// - Parameter address: The memory address.
    /// - Returns: A byte from memory.
    func readByte(_ address: UInt16) -> UInt8 {
        bus.read(address)
    }
    
    /// Create a word from bytes read from `address` and `address + 1`.
    /// - Parameter address: The address in memory where the word to read starts.
    /// - Returns: A word.
    func readWord(_ address: UInt16) -> UInt16 {
        let highByte = readByte(address)
        let lowByte = readByte(address &+ 1)
        
        return .createWord(highByte: highByte, lowByte: lowByte)
    }
    
    /// Write a single byte to memory.
    /// - Parameters:
    ///   - address: The address where to store the data.
    ///   - data: A byte.
    func writeByte(_ address: UInt16, data: UInt8) {
        bus.write(address, data: data)
    }
    
    /// Write a word to memory.
    /// - Parameters:
    ///   - address: The address where to store the data.
    ///   - data: A word.
    func writeWord(_ address: UInt16, data: UInt16) {
        bus.write(address, data: data.highByte)
        bus.write(address + 1, data: data.lowByte)
    }
    
    // MARK: - Flags
    
    /// Set a condition code on or off.
    /// - Parameters:
    ///   - flag: The flag to set.
    ///   - isOn: Whether the flag is on or not.
    func setCC(_ flag: CCFlag, _ isOn: Bool) {
        if isOn {
            // OR the current flags against the given flag.
            CC |= flag.rawValue
            ccString = "0"
        } else {
            // AND the current flags against the flipped bits on the given flag.
            CC &= ~flag.rawValue
            ccString = "0"
        }
    }
    
    /// Read the state of a condition code.
    /// - Parameter flag: The flag to read.
    /// - Returns: A `Bool` to indicate whether the flag is enabled or not.
    func readCC(_ flag: CCFlag) -> Bool {
        (CC & flag.rawValue) > 0
    }
    
    /// Load a program into memory.
    func loadMemory(fromFilePath filePath: String, loadAddress : UInt16 = 0) throws {
        let fileURL = URL(fileURLWithPath: filePath)
        let data = try Data(contentsOf: fileURL)
        if data.count > UInt16.max - loadAddress {
            throw CPUError.invalidMemorySize
        }
        var address : UInt16 = loadAddress
        for byte in data {
            bus.write(address, data: byte)
            address = address + 1
        }
    }
    
    // MARK: - Debugging
    
    /*
     func getFlagString() -> String {
     let statusFlags = CCFlag.allCases
     let firstRow = statusFlags.map(\.letter).joined()
     let secondRow = statusFlags.map { String(readCC($0).value) }.joined()
     
     return [firstRow, secondRow].joined(separator: " - ")
     }
     */
}
