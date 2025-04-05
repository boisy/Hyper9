import Testing
@testable import Turbo9Sim

struct TestINCA {
    @Test func test_inca() async throws {
        let cpu = Turbo9CPU.create(ram: [], acca: 0x0F)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .inca, addressMode: .inh)
        
        #expect(cpu.A == 0x10)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.overflow) == false)
    }
    
    @Test func test_inca_negative_set() async throws {
        let cpu = Turbo9CPU.create(ram: [], acca: 0x81)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .inca, addressMode: .inh)
        
        #expect(cpu.A == 0x82)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.overflow) == false)
    }
    
    @Test func test_inca_zero_set() async throws {
        let cpu = Turbo9CPU.create(ram: [], acca:0xFF)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .inca, addressMode: .inh)
        
        #expect(cpu.A == 0x00)
        #expect(cpu.readCC(.zero) == true)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.overflow) == false)
    }
    
    @Test func test_inca_overflow_set() async throws {
        let cpu = Turbo9CPU.create(ram: [], acca:0x7F)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .inca, addressMode: .inh)
        
        #expect(cpu.A == 0x80)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.overflow) == true)
    }
}
