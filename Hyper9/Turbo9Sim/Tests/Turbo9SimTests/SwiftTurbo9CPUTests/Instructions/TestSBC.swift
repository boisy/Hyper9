import Testing
@testable import Turbo9Sim

struct TestSBCA {
    @Test func test_sbca_immediate_flags_false() async throws {
        let storedByte : UInt8 = 0x02
        let accumulator : UInt8 = 0x03
        let cpu = Turbo9CPU.create(ram: [storedByte], acca: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        cpu.setCC(.carry, false)
        
        try cpu.perform(instruction: .sbca, addressMode: .imm8)
        
        #expect(cpu.A == accumulator &- storedByte &- 0x00)
        #expect(cpu.readCC(.halfcarry) == false)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
        #expect(cpu.readCC(.carry) == false)
    }
    
    @Test func test_sbca_immediate_carry_true() async throws {
        let storedByte : UInt8 = 0x02
        let accumulator : UInt8 = 0x05
        let cpu = Turbo9CPU.create(ram: [storedByte], acca: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        cpu.setCC(.carry, true)
        
        try cpu.perform(instruction: .sbca, addressMode: .imm8)
        
        #expect(cpu.A == accumulator &- storedByte &- 0x01)
        #expect(cpu.readCC(.halfcarry) == false)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
        #expect(cpu.readCC(.carry) == false)
    }
    
    @Test func test_sbca_immediate_overflow_true() async throws {
        let storedByte : UInt8 = 0x7E
        let accumulator : UInt8 = 0x03
        let cpu = Turbo9CPU.create(ram: [storedByte], acca: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        cpu.setCC(.carry, false)

        try cpu.perform(instruction: .sbca, addressMode: .imm8)
        
        #expect(cpu.A == accumulator &- storedByte &- 0x00)
        #expect(cpu.readCC(.halfcarry) == false)
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == true)
        #expect(cpu.readCC(.carry) == false)
    }
    
    @Test func test_adca_immediate_halfcarry_false() async throws {
        let storedByte : UInt8 = 0x00
        let accumulator : UInt8 = 0xFE
        let cpu = Turbo9CPU.create(ram: [storedByte], acca: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        cpu.setCC(.carry, false)

        try cpu.perform(instruction: .adca, addressMode: .imm8)
        
        #expect(cpu.A == storedByte &+ accumulator &+ 0x00)
        #expect(cpu.readCC(.halfcarry) == false)
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
        #expect(cpu.readCC(.carry) == false)
    }
    
    @Test func test_adca_immediate_halfcarry_true() async throws {
        let storedByte : UInt8 = 0x01
        let accumulator : UInt8 = 0x0F
        let cpu = Turbo9CPU.create(ram: [storedByte], acca: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        cpu.setCC(.carry, false)

        try cpu.perform(instruction: .adca, addressMode: .imm8)
        
        #expect(cpu.A == storedByte &+ accumulator &+ 0x00)
        #expect(cpu.readCC(.halfcarry) == true)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
        #expect(cpu.readCC(.carry) == false)
    }
    
    @Test func test_adca_immediate_carry_true() async throws {
        let storedByte : UInt8 = 0x03
        let accumulator : UInt8 = 0x02
        let cpu = Turbo9CPU.create(ram: [storedByte], acca: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        cpu.setCC(.carry, true)
        
        try cpu.perform(instruction: .adca, addressMode: .imm8)
        
        #expect(cpu.A == storedByte &+ accumulator &+ 0x01)
    }
}
