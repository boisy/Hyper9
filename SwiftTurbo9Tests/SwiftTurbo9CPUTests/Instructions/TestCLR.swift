import Testing
@testable import Turbo9Sim

struct TestCLRAB {
    @Test func test_clra() async throws {
        let cpu = CPU.create(ram: [0xFF])

        cpu.setupAddressing(using: .inh)
        cpu.setCC(.negative, true)
        cpu.setCC(.zero, false)
        cpu.setCC(.overflow, true)
        cpu.setCC(.carry, true)

        try cpu.perform(instruction: .clra, addressMode: .inh)
        
        #expect(cpu.A == 0x00)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == true)
        #expect(cpu.readCC(.overflow) == false)
        #expect(cpu.readCC(.carry) == false)
    }
    
    @Test func test_clrb() async throws {
        let cpu = CPU.create(ram: [0xFF])

        cpu.setupAddressing(using: .inh)
        cpu.setCC(.negative, true)
        cpu.setCC(.zero, false)
        cpu.setCC(.overflow, true)
        cpu.setCC(.carry, true)

        try cpu.perform(instruction: .clrb, addressMode: .inh)
        
        #expect(cpu.B == 0x00)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == true)
        #expect(cpu.readCC(.overflow) == false)
        #expect(cpu.readCC(.carry) == false)
    }
}
