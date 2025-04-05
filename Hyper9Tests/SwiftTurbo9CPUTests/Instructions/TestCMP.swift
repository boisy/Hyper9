import Testing
@testable import Turbo9Sim

struct TestCMPA {
    @Test func test_cmpa_negative_true_carry_true() async throws {
        let cpu = Turbo9CPU.create(ram: [0xFF], acca: 0x00)
        
        cpu.setupAddressing(using: .imm8)
        cpu.setCC(.negative, true)
        cpu.setCC(.zero, false)
        cpu.setCC(.overflow, true)
        cpu.setCC(.carry, true)
        
        try cpu.perform(instruction: .cmpa, addressMode: .imm8)
        
        #expect(cpu.A == 0x00)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
        #expect(cpu.readCC(.carry) == true)
    }
    
    @Test func test_cmpa_negative_true_overflow_true_carry_true() async throws {
        let cpu = Turbo9CPU.create(ram: [0xFF], acca: 0xFE)
        
        cpu.setupAddressing(using: .imm8)
        cpu.setCC(.negative, true)
        cpu.setCC(.zero, false)
        cpu.setCC(.overflow, true)
        cpu.setCC(.carry, true)
        
        try cpu.perform(instruction: .cmpa, addressMode: .imm8)
        
        #expect(cpu.A == 0xFE)
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
        #expect(cpu.readCC(.carry) == true)
    }
    
    @Test func test_cmpd_negative_true_carry_true() async throws {
        let cpu = Turbo9CPU.create(ram: [0xFF, 0xFF], acca: 0x00, accb: 0x00)
        
        cpu.setupAddressing(using: .imm16)
        cpu.setCC(.negative, true)
        cpu.setCC(.zero, false)
        cpu.setCC(.overflow, true)
        cpu.setCC(.carry, true)
        
        try cpu.perform(instruction: .cmpd, addressMode: .imm16)
        
        #expect(cpu.D == 0x0000)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
        #expect(cpu.readCC(.carry) == true)
    }
    
    @Test func test_cmpd_negative_true_overflow_true_carry_true() async throws {
        let cpu = Turbo9CPU.create(ram: [0xFF, 0xFF], acca: 0xFF, accb: 0xFE)

        cpu.setupAddressing(using: .imm16)
        cpu.setCC(.negative, true)
        cpu.setCC(.zero, false)
        cpu.setCC(.overflow, true)
        cpu.setCC(.carry, true)

        try cpu.perform(instruction: .cmpd, addressMode: .imm16)
        
        #expect(cpu.D == 0xFFFE)
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
        #expect(cpu.readCC(.carry) == true)
    }
}
