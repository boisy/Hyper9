import Testing
@testable import Turbo9Sim

struct TestADDA {
    @Test func test_adda_immediate() async throws {
        let storedByte : UInt8 = 0x03
        let accumulator : UInt8 = 0x02
        let cpu = CPU.create(ram: [storedByte], acca: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .adda, addressMode: .imm8)
        
        #expect(cpu.A == storedByte + accumulator)
        
        #expect(cpu.readCC(.carry) == false)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
    }
    
    @Test func test_adda_direct_all_flags() async throws {
        let storedByte : UInt8 = 0x02
        let accumulator : UInt8 = 0x0E
        let cpu = CPU.create(ram: [0x02, 0x00, storedByte], acca: accumulator)
        
        cpu.DP = 0x00
        cpu.setupAddressing(using: .dir)
        
        try cpu.perform(instruction: .adda, addressMode: .dir)
        
        #expect(cpu.A == storedByte + accumulator)
        
        #expect(cpu.readCC(.halfcarry) == true)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
        #expect(cpu.readCC(.carry) == false)
    }
    
    @Test func test_adda_immediate_zero() async throws {
        let storedByte : UInt8 = 0xFF
        let accumulator : UInt8 = 0x01
        let cpu = CPU.create(ram: [storedByte], acca: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .adda, addressMode: .imm8)
        #expect(cpu.A == 0x00)
        #expect(cpu.readCC(.zero) == true)
    }
    
    @Test func test_adda_immediate_carry_true() async throws {
        let storedByte : UInt8 = 0xFF
        let accumulator : UInt8 = 0x01
        let cpu = CPU.create(ram: [storedByte], acca: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .adda, addressMode: .imm8)
        #expect(cpu.A == 0x00)
        #expect(cpu.readCC(.carry) == true)
    }
    
    @Test func test_adda_immediate_negative_true() async throws {
        let storedByte : UInt8 = 0x7F
        let accumulator : UInt8 = 0x01
        let cpu = CPU.create(ram: [storedByte], acca: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .adda, addressMode: .imm8)
        #expect(cpu.A == storedByte + accumulator)
        #expect(cpu.readCC(.negative) == true)
    }
    
    @Test func test_adda_immediate_overflow_true() async throws {
        let storedByte : UInt8 = 0x7F
        let accumulator : UInt8 = 0x01
        let cpu = CPU.create(ram: [storedByte], acca: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .adda, addressMode: .imm8)
        #expect(cpu.A == storedByte + accumulator)
        #expect(cpu.readCC(.overflow) == true)
    }
    
    @Test func test_adda_extended() async throws {
        let storedByte : UInt8 = 0x7F
        let accumulator : UInt8 = 0x01
        let cpu = CPU.create(ram: [0x00, 0x02, storedByte], acca: accumulator)
        cpu.setupAddressing(using: .ext)
        
        try cpu.perform(instruction: .adda, addressMode: .ext)
        #expect(cpu.A == storedByte + accumulator)
        #expect(cpu.readCC(.overflow) == true)
    }
}

struct TestADDB {
    @Test func test_addb_immediate() async throws {
        let storedByte : UInt8 = 0x03
        let accumulator : UInt8 = 0x02
        let cpu = CPU.create(ram: [storedByte], accb: accumulator)
        cpu.setupAddressing(using: .imm8)

        try cpu.perform(instruction: .addb, addressMode: .imm8)

        #expect(cpu.B == storedByte + accumulator)

        #expect(cpu.readCC(.carry) == false)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
    }

    @Test func test_addb_direct_all_flags() async throws {
        let storedByte : UInt8 = 0x0E
        let accumulator : UInt8 = 0x02
        let cpu = CPU.create(ram: [0x02, 0x00, storedByte], accb: accumulator)
        
        cpu.DP = 0x00
        cpu.setupAddressing(using: .dir)

        try cpu.perform(instruction: .addb, addressMode: .dir)

        #expect(cpu.B == storedByte + accumulator)

        #expect(cpu.readCC(.halfcarry) == false)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
        #expect(cpu.readCC(.carry) == false)
    }


    @Test func test_addb_immediate_zero() async throws {
        let storedByte : UInt8 = 0xFF
        let accumulator : UInt8 = 0x01
        let cpu = CPU.create(ram: [storedByte], accb: accumulator)
        cpu.setupAddressing(using: .imm8)

        try cpu.perform(instruction: .addb, addressMode: .imm8)
        #expect(cpu.B == 0x00)
        #expect(cpu.readCC(.zero) == true)
    }

    @Test func test_addb_immediate_carry_true() async throws {
        let storedByte : UInt8 = 0xFF
        let accumulator : UInt8 = 0x01
        let cpu = CPU.create(ram: [storedByte], accb: accumulator)
        cpu.setupAddressing(using: .imm8)

        try cpu.perform(instruction: .addb, addressMode: .imm8)
        #expect(cpu.B == 0x00)
        #expect(cpu.readCC(.carry) == true)
    }

    @Test func test_addb_immediate_negative_true() async throws {
        let storedByte : UInt8 = 0x7F
        let accumulator : UInt8 = 0x01
        let cpu = CPU.create(ram: [storedByte], accb: accumulator)
        cpu.setupAddressing(using: .imm8)

        try cpu.perform(instruction: .addb, addressMode: .imm8)
        #expect(cpu.B == storedByte + accumulator)
        #expect(cpu.readCC(.negative) == true)
    }

    @Test func test_addb_sets_overflow_flag() async throws {
        let storedByte : UInt8 = 0x7F
        let accumulator : UInt8 = 0x01
        let cpu = CPU.create(ram: [storedByte], accb: accumulator)
        cpu.setupAddressing(using: .imm8)

        try cpu.perform(instruction: .addb, addressMode: .imm8)
        #expect(cpu.B == storedByte + accumulator)
        #expect(cpu.readCC(.overflow) == true)
    }
}

struct TestADDD {
    @Test func test_addd_immediate() async throws {
        let storedWord : UInt16 = 0x0304
        let accumulator : UInt16 = 0x1F02
        let cpu = CPU.create(ram: [storedWord.highByte, storedWord.lowByte], acca: accumulator.highByte, accb: accumulator.lowByte)
        cpu.setupAddressing(using: .imm8)

        try cpu.perform(instruction: .addd, addressMode: .imm8)

        #expect(cpu.D == storedWord + accumulator)

        #expect(cpu.readCC(.carry) == false)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
    }

    @Test func test_addd_direct_all_flags() async throws {
        let storedWord : UInt16 = 0xE304
        let accumulator : UInt16 = 0x23F2
        let cpu = CPU.create(ram: [0x02, 0x00, storedWord.highByte, storedWord.lowByte], acca: accumulator.highByte, accb: accumulator.lowByte)
        
        cpu.DP = 0x00
        cpu.setupAddressing(using: .dir)

        try cpu.perform(instruction: .addd, addressMode: .dir)

        #expect(cpu.D == storedWord &+ accumulator)

        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
        #expect(cpu.readCC(.carry) == false)
    }

    @Test func test_addd_immediate_carry_true() async throws {
        let storedWord : UInt16 = 0xE304
        let accumulator : UInt16 = 0x23F2
        let cpu = CPU.create(ram: [storedWord.highByte, storedWord.lowByte], acca: accumulator.highByte, accb: accumulator.lowByte)

        cpu.setCC(.carry, true)

        cpu.setupAddressing(using: .imm16)

        try cpu.perform(instruction: .addd, addressMode: .imm16)

        #expect(cpu.D == storedWord &+ accumulator)
    }

    @Test func test_addd_immediate_zero_true() async throws {
        let storedWord : UInt16 = 0xFFFF
        let accumulator : UInt16 = 0x0001
        let cpu = CPU.create(ram: [storedWord.highByte, storedWord.lowByte], acca: accumulator.highByte, accb: accumulator.lowByte)

        cpu.setupAddressing(using: .imm16)

        try cpu.perform(instruction: .addd, addressMode: .imm16)

        #expect(cpu.D == 0)
        #expect(cpu.readCC(.zero) == true)
    }

    @Test func test_addd_immediate_negative_true() async throws {
        let storedWord : UInt16 = 0xFFEF
        let accumulator : UInt16 = 0x0001
        let cpu = CPU.create(ram: [storedWord.highByte, storedWord.lowByte], acca: accumulator.highByte, accb: accumulator.lowByte)

        cpu.setupAddressing(using: .imm16)

        try cpu.perform(instruction: .addd, addressMode: .imm16)

        #expect(cpu.readCC(.negative) == true)
    }

    @Test func test_addd_overflow_true() async throws {
        let storedWord : UInt16 = 0x7FFF
        let accumulator : UInt16 = 0x0301
        let cpu = CPU.create(ram: [storedWord.highByte, storedWord.lowByte], acca: accumulator.highByte, accb: accumulator.lowByte)

        cpu.setupAddressing(using: .imm16)

        try cpu.perform(instruction: .addd, addressMode: .imm16)

        #expect(cpu.readCC(.overflow) == true)
    }
}
