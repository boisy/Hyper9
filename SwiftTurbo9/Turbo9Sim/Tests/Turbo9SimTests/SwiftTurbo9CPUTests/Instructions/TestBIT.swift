import Testing
@testable import Turbo9Sim

struct TestBITA {
    @Test func test_bita_immediate() async throws {
        let storedByte : UInt8 = 0x11
        let accumulator : UInt8 = 0x10
        let cpu = CPU.create(ram: [storedByte], acca: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .bita, addressMode: .imm8)
        
        #expect(cpu.A == storedByte & accumulator)
        
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
    }
    
    @Test func test_bita_immediate_negative_true() async throws {
        let storedByte : UInt8 = 0x81
        let accumulator : UInt8 = 0x80
        let cpu = CPU.create(ram: [storedByte], acca: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .bita, addressMode: .imm8)
        
        #expect(cpu.A == storedByte & accumulator)
        
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
    }
    
    @Test func test_bita_immediate_zero_true() async throws {
        let storedByte : UInt8 = 0x01
        let accumulator : UInt8 = 0x00
        let cpu = CPU.create(ram: [storedByte], acca: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .bita, addressMode: .imm8)
        
        #expect(cpu.A == storedByte & accumulator)
        
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == true)
        #expect(cpu.readCC(.overflow) == false)
    }
}

struct TestBITB {
    @Test func test_bitb_immediate() async throws {
        let storedByte : UInt8 = 0x11
        let accumulator : UInt8 = 0x10
        let cpu = CPU.create(ram: [storedByte], accb: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .bitb, addressMode: .imm8)
        
        #expect(cpu.B == storedByte & accumulator)
        
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
    }
    
    @Test func test_bitb_immediate_negative_true() async throws {
        let storedByte : UInt8 = 0x81
        let accumulator : UInt8 = 0x80
        let cpu = CPU.create(ram: [storedByte], accb: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .bitb, addressMode: .imm8)
        
        #expect(cpu.B == storedByte & accumulator)
        
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
    }
    
    @Test func test_bitb_immediate_zero_true() async throws {
        let storedByte : UInt8 = 0x01
        let accumulator : UInt8 = 0x00
        let cpu = CPU.create(ram: [storedByte], accb: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .bitb, addressMode: .imm8)
        
        #expect(cpu.B == storedByte & accumulator)
        
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == true)
        #expect(cpu.readCC(.overflow) == false)
    }
}
