import Foundation

class Disassembler: CPU {

    // MARK: - Private properties

    private var program: [UInt8] = []
    @Published var operations = [Operation]()
    private var filePath : String = ""
    
    // MARK: - Init

    init(program: [UInt8] = [], pc: UInt16 = 0x00) {
        self.program = program

        super.init(
            bus: Bus(ram: .createRam(withProgram: program)),
            pc: pc
        )
    }

    init(filePath: String, pc: UInt16 = 0x00) {
        self.filePath = filePath
        let fileURL = URL(fileURLWithPath: self.filePath)
        do {
            program = try [UInt8](Data(contentsOf: fileURL))
        } catch {
            program = []
        }

        super.init(
            bus: Bus(ram: .createRam(withProgram: program)),
            pc: pc
        )
    }

    func reload() throws {
        try reload(filePath: self.filePath)
    }
    
    func reload(filePath : String) throws {
        self.filePath = filePath
        let fileURL = URL(fileURLWithPath: self.filePath)
        do {
            let program = try Data(contentsOf: fileURL)
            self.program = [UInt8](program)
            let newRam = [UInt8].createRam(withProgram: self.program, loadAddress: UInt16(0x10000 - program.count))
            bus.ram = newRam
            try self.reset()
        } catch {
            fatalError("Could not read file \(fileURL)")
        }
    }
    
    init(from filePath: String, pc: UInt16 = 0x00) {
        self.filePath = filePath
        let fileURL = URL(fileURLWithPath: filePath)
        do {
            let program = try Data(contentsOf: fileURL)
            self.program = [UInt8](program)
        } catch {
            fatalError("Could not read file \(fileURL)")
        }
        super.init(
            bus: Bus(ram: .createRam(withProgram: self.program)),
            pc: pc
        )
    }

    // MARK: - Internal methods

    func disassembleInstruction(address : UInt16) -> Operation {
        PC = address
        let offset = PC
        let opcodeByte = readByte(PC)
        PC = PC &+ 1
        

        // Read byte and setup addressing mode.
        let opcode = Self.opcodes[Int(opcodeByte)]
        setupAddressing(using: opcode.1)

        let operand = getOperand(using: opcode.1, offset: 0)

        let operation = Operation(offset: offset, preByte: .none, opcode: opcodeByte, instruction: opcode.0, operand: operand, postOperand: PostOperand.none)

        // Map operations to String and return it.
        return operation
    }

    func disassemble(instructionCount : UInt = UInt.max, startPC : UInt16 = UInt16.max) -> [String] {
        var numberOfInstructionsToDisassemble = instructionCount
        let oldPC = PC
        let oldA = A
        let oldB = B
        let oldDP = DP
        let oldCC = CC
        let oldX = X
        let oldY = Y
        let oldU = U
        let oldS = S
        operations = []

        if startPC != UInt16.max {
            PC = startPC
        }
        while program.isWithinBounds(PC) {
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
                        // There is one post operand
                        postOperand = PostOperand.byte(readByte(PC - 1))
                    } else {
                        // There are two post operands
                        postOperand = PostOperand.word(readWord(PC - 2))
                    }
                } else {
                }

                if opcode.0 == .swi2 {
                    PC = PC &+ 1
                    let operand = getOperand(using: .imm8, offset: PC)
                    let os9 = OpCode(.swi2, .imm8, 1)
                    let operation = Operation(offset: offset, preByte: prebyte, opcode: opcodeByte, instruction: os9.0, operand: operand, postOperand: postOperand)
                    operations.append(operation)
                } else {
                    let operation = Operation(offset: offset, preByte: prebyte, opcode: opcodeByte, instruction: opcode.0, operand: operand, postOperand: postOperand)
                    operations.append(operation)
                }
            }
            if numberOfInstructionsToDisassemble != UInt.max {
                numberOfInstructionsToDisassemble = numberOfInstructionsToDisassemble - 1
                if numberOfInstructionsToDisassemble == 0 {
                    break
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

        // Map operations to String and return it.
        return operations.map { $0.asCode }
    }

    func checkDisassembly() {
        if let last = operations.last, let first = operations.first {
            if PC >= last.offset || PC <= first.offset {
                let _ = disassemble(instructionCount: 30, startPC: PC &- 30)
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
