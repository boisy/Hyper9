import Testing
@testable import Turbo9Sim

struct TestCOMA {
    @Test func test_coma_negative_true_carry_true() async throws {
        let cpu = Turbo9CPU.create(ram: [0xFF], acca: 0x00)
        
        cpu.setupAddressing(using: .inh)
        cpu.setCC(.negative, true)
        cpu.setCC(.zero, false)
        cpu.setCC(.overflow, true)
        cpu.setCC(.carry, true)
        
        try cpu.perform(instruction: .coma, addressMode: .inh)
        
        #expect(cpu.A == 0xFF)
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
        #expect(cpu.readCC(.carry) == true)
    }
    
    @Test func test_coma_negative_true_overflow_true_carry_true() async throws {
        let cpu = Turbo9CPU.create(ram: [0xFF], acca: 0xFF)
        
        cpu.setupAddressing(using: .inh)
        cpu.setCC(.negative, true)
        cpu.setCC(.zero, false)
        cpu.setCC(.overflow, true)
        cpu.setCC(.carry, true)
        
        try cpu.perform(instruction: .coma, addressMode: .inh)
        
        #expect(cpu.A == 0x00)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == true)
        #expect(cpu.readCC(.overflow) == false)
        #expect(cpu.readCC(.carry) == true)
    }
}
