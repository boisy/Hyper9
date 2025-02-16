import Testing
@testable import Turbo9Sim

struct TestEORA {
    @Test func test_eora_negative_true() async throws {
        let cpu = Turbo9CPU.create(ram: [0xF0], acca: 0x0F)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .eora, addressMode: .imm8)
        
        #expect(cpu.A == 0xFF)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.overflow) == false)
    }
    
    @Test func test_eora_negative_false() async throws {
        let cpu = Turbo9CPU.create(ram: [0x01], acca: 0xF1)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .eora, addressMode: .imm8)
        
        #expect(cpu.A == 0xF0)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.overflow) == false)
    }
}
