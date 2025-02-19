import Testing
@testable import Turbo9Sim

struct TestSUB {
    @Test func test_suba_immediate() async throws {
        let storedByte : UInt8 = 0x03
        let accumulator : UInt8 = 0x02
        let cpu = Turbo9CPU.create(ram: [storedByte], acca: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .suba, addressMode: .imm8)
        
        #expect(cpu.A == accumulator &- storedByte)

        #expect(cpu.readCC(.carry) == true)
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
    }
    
    @Test func test_suba_immediate_2() async throws {
        let storedByte : UInt8 = 100
        let accumulator : UInt8 = 5
        let cpu = Turbo9CPU.create(ram: [storedByte], acca: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .suba, addressMode: .imm8)
        
        #expect(cpu.A == accumulator &- storedByte)

        #expect(cpu.readCC(.carry) == true)
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
    }
    
    @Test func test_suba_direct_all_flags() async throws {
        let storedByte : UInt8 = 0x02
        let accumulator : UInt8 = 0x0E
        let cpu = Turbo9CPU.create(ram: [0x02, 0x00, storedByte], acca: accumulator)
        
        cpu.DP = 0x00
        cpu.setupAddressing(using: .dir)
        
        try cpu.perform(instruction: .suba, addressMode: .dir)
        
        #expect(cpu.A == accumulator &- storedByte)
        
        #expect(cpu.readCC(.halfcarry) == false)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
        #expect(cpu.readCC(.carry) == false)
    }
    
    @Test func test_suba_immediate_zero() async throws {
        let storedByte : UInt8 = 0x01
        let accumulator : UInt8 = 0x01
        let cpu = Turbo9CPU.create(ram: [storedByte], acca: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .suba, addressMode: .imm8)
        #expect(cpu.A == 0x00)
        #expect(cpu.readCC(.zero) == true)
    }
    
    @Test func test_suba_immediate_carry_true() async throws {
        let storedByte : UInt8 = 0xF1
        let accumulator : UInt8 = 0x01
        let cpu = Turbo9CPU.create(ram: [storedByte], acca: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .suba, addressMode: .imm8)
        #expect(cpu.A == accumulator &- storedByte)
        #expect(cpu.readCC(.carry) == true)
    }
    
    @Test func test_suba_immediate_negative_true() async throws {
        let storedByte : UInt8 = 0x7F
        let accumulator : UInt8 = 0x01
        let cpu = Turbo9CPU.create(ram: [storedByte], acca: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .suba, addressMode: .imm8)
        #expect(cpu.A == accumulator &- storedByte)
        #expect(cpu.readCC(.negative) == true)
    }
    
    @Test func test_suba_immediate_overflow_true() async throws {
        let storedByte : UInt8 = 0x7F
        let accumulator : UInt8 = 0x01
        let cpu = Turbo9CPU.create(ram: [storedByte], acca: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .suba, addressMode: .imm8)
        #expect(cpu.A == accumulator &- storedByte)
        #expect(cpu.readCC(.overflow) == true)
    }
    
    @Test func test_suba_extended() async throws {
        let storedByte : UInt8 = 0x7F
        let accumulator : UInt8 = 0x01
        let cpu = Turbo9CPU.create(ram: [0x00, 0x02, storedByte], acca: accumulator)
        cpu.setupAddressing(using: .ext)
        
        try cpu.perform(instruction: .suba, addressMode: .ext)
        #expect(cpu.A == accumulator &- storedByte)
        #expect(cpu.readCC(.overflow) == true)
    }
}

struct TestSUBD {
    @Test func test_subd_immediate() async throws {
        let cpu = Turbo9CPU.create(ram: [0x03, 0x00], acca: 0x02, accb: 0x00)
        cpu.setupAddressing(using: .imm16)
        
        try cpu.perform(instruction: .subd, addressMode: .imm16)
        
        #expect(cpu.D == 0x0200 &- 0x0300)

        #expect(cpu.readCC(.carry) == true)
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == true)
    }
    
}
