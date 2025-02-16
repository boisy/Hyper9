import Foundation

public class Disassembler: Turbo9CPU {

    // MARK: - Private properties

    private var program: [UInt8] = []
    public var operations = [Turbo9Operation]()
    private var filePath : String = ""
    private var logPath : String = ""
    private var fileHandle : FileHandle?

    // MARK: - Init

    public init(program: [UInt8] = [], pc: UInt16 = 0x00, logPath: String = "") {
        self.program = program
        self.logPath = logPath

        if !FileManager.default.fileExists(atPath: self.logPath) {
            // Create an empty file
            FileManager.default.createFile(atPath: self.logPath, contents: nil, attributes: nil)
        }
        do {
            let logURL = URL(fileURLWithPath: self.logPath)
            self.fileHandle = try FileHandle(forWritingTo: logURL)
        } catch {
        }

        super.init(
            bus: Bus(memory: .createRam(withProgram: program)),
            pc: pc
        )
    }

    public init(filePath: String, pc: UInt16 = 0x00, logPath: String = "") {
        self.filePath = filePath
        self.logPath = logPath
        let fileURL = URL(fileURLWithPath: self.filePath)
        do {
            program = try [UInt8](Data(contentsOf: fileURL))
        } catch {
            program = []
        }

        if !FileManager.default.fileExists(atPath: self.logPath) {
            // Create an empty file
            FileManager.default.createFile(atPath: self.logPath, contents: nil, attributes: nil)
        }
        do {
            let logURL = URL(fileURLWithPath: self.logPath)
            self.fileHandle = try FileHandle(forWritingTo: logURL)
        } catch {
        }
        
        super.init(
            bus: Bus(memory: .createRam(withProgram: program)),
            pc: pc
        )
    }

    public func load(url : URL) throws {
        do {
            let program = try Data(contentsOf: url)
            self.program = [UInt8](program)
            let newRam = [UInt8].createRam(withProgram: self.program, loadAddress: UInt16(0x10000 - program.count))
            bus.memory = newRam
            bus.originalRam = newRam
            try self.reset()
        } catch {
            fatalError("Could not read file \(url)")
        }
    }
    
    public init(from url: URL, pc: UInt16 = 0x00) {
        do {
            let program = try Data(contentsOf: url)
            self.program = [UInt8](program)
        } catch {
            fatalError("Could not read file \(url)")
        }
        super.init(
            bus: Bus(memory: .createRam(withProgram: self.program)),
            pc: pc
        )
    }

    // MARK: - Internal methods

    public func disassemble(pc : UInt16 = UInt16.max) -> Turbo9Operation? {
        let oldPC = PC
        let oldA = A
        let oldB = B
        let oldDP = DP
        let oldCC = CC
        let oldX = X
        let oldY = Y
        let oldU = U
        let oldS = S

        var operation : Turbo9Operation? = nil
        
        if pc != UInt16.max {
            PC = pc
        }
        
        if program.isWithinBounds(PC) {
            let offset = PC
            var prebyte : PreByte = .none, opcodeByte = readByte(PC)
            PC = PC &+ 1

            // Read byte and setup addressing mode.
            var opcode : OpCode?
            if opcodeByte == 0x10 {
                prebyte = .page10
                opcodeByte = readByte(PC)
                opcode = Self.opcodes10[Int(opcodeByte)]
                PC = PC &+ 1
            } else if opcodeByte == 0x11 {
                prebyte = .page11
                opcodeByte = readByte(PC)
                opcode = Self.opcodes11[Int(opcodeByte)]
                PC = PC &+ 1
            } else {
                opcode = Self.opcodes[Int(opcodeByte)]
            }
            if let opcode = opcode {
                let currentPC = PC
                setupAddressing(using: opcode.1)
                let pcOffset = PC &- currentPC &- 1
                
                let operand = getOperand(using: opcode.1, offset: pcOffset)
                var postOperand : PostOperand = PostOperand.none
                if opcode.1 == .ind {
                     // Since the postbyte dictates how many bytes follow, we do the processing here.
                    if pcOffset == 1 {
                        // There is one post operand byte
                        postOperand = PostOperand.byte(readByte(PC &- 1))
                    } else if pcOffset == 2 {
                        // There are two post operand bytes
                        postOperand = PostOperand.word(readWord(PC &- 2))
                    }
                } else {
                }

                if opcode.0 == .swi2 {
                    PC = PC &+ 1
                    let operand = getOperand(using: .imm8, offset: PC)
                    let os9 = OpCode(.swi2, .imm8, 1)
                    operation = Turbo9Operation(offset: offset, preByte: prebyte, opcode: opcodeByte, instruction: os9.0, operand: operand, postOperand: postOperand, size: PC &- oldPC)
                } else {
                    operation = Turbo9Operation(offset: offset, preByte: prebyte, opcode: opcodeByte, instruction: opcode.0, operand: operand, postOperand: postOperand, size: PC &- oldPC)
                }
            }
        }
        
        PC = oldPC
        A = oldA
        B = oldB
        X = oldX
        Y = oldY
        U = oldU
        S = oldS
        DP = oldDP
        CC = oldCC

        return operation
    }

    public func disassemble(instructionCount : UInt = 1, startPC : UInt16 = UInt16.max) -> [String] {
        let oldPC = PC
        for _ in 0..<instructionCount {
            if let op = disassemble(pc: PC) {
                PC = PC &+ UInt16(op.size)
                operations.append(op)
             }
        }
        PC = oldPC
        // Map operations to String and return it.
        return operations.map { $0.asCode }
    }

    override public func step() throws {
        let oldPC = PC
        let op = disassemble(pc: PC)
        PC = oldPC
        try super.step()
        if let fh = self.fileHandle, let op = op {
//            let data = (String(format:"%@ DP=%02X CC=%@ A=%02X B=%02X X=%04X Y=%04X U=%04X S=%04X\n",
//                               op[0].asCode, DP, ccString, A, B, X, Y, U, S)).data(using: .utf8)!
            let data = (String(format:"%@ \n",
                               op.asCode)).data(using: .utf8)!
            fh.write(data)
        }
    }
    
    public func checkDisassembly() {
        if let last = operations.last, let first = operations.first {
            if PC >= last.offset || PC <= first.offset {
                operations = []
                let _ = disassemble(instructionCount: 30, startPC: PC)
            }
        }
    }
    
    // MARK: - Private methods

    private func getOperand(using addressMode: AddressMode, offset: UInt16) -> Operand {
        switch addressMode {
        case .inh:
            return .none
        case .imm8:
            return .immediate8(readByte(PC &- 1))
        case .imm16:
            return .immediate16(readWord(PC &- 2))
        case .dir:
            return .direct(readByte(PC &- 1))
        case .ext:
            return .extended(readWord(PC &- 2))
        case .ind:
            return .indexed(readByte(PC &- 1 &- offset))
        case .rel8:
            return .relative8(readByte(PC &- 1))
        case .rel16:
            return .relative16(readWord(PC &- 2))
        }
    }
}
