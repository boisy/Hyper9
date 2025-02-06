import Testing
@testable import Turbo9Sim

struct TestDECA {
    @Test func test_deca() async throws {
        let cpu = CPU.create(ram: [], acca: 0x0F)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .deca, addressMode: .inh)
        
        #expect(cpu.A == 0x0E)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.overflow) == false)
    }
    
    @Test func test_deca_negative_set() async throws {
        let cpu = CPU.create(ram: [], acca: 0x00)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .deca, addressMode: .inh)
        
        #expect(cpu.A == 0xFF)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.overflow) == false)
    }
    
    @Test func test_deca_zero_set() async throws {
        let cpu = CPU.create(ram: [], acca:0x01)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .deca, addressMode: .inh)
        
        #expect(cpu.A == 0x00)
        #expect(cpu.readCC(.zero) == true)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.overflow) == false)
    }
    
    @Test func test_deca_overflow_set() async throws {
        let cpu = CPU.create(ram: [], acca:0x80)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .deca, addressMode: .inh)
        
        #expect(cpu.A == 0x7F)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.overflow) == true)
    }
}
