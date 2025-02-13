import Testing
@testable import Turbo9Sim

struct TestNEGA {
    @Test func test_nega_0x00() async throws {
        let cpu = CPU.create(ram: [], acca: 0x00)
        
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .nega, addressMode: .inh)
        
        #expect(cpu.A == 0x00)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == true)
        #expect(cpu.readCC(.overflow) == false)
        #expect(cpu.readCC(.carry) == false)
    }
    
    @Test func test_nega_0xFF() async throws {
        let cpu = CPU.create(ram: [], acca: 0xFF)
        
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .nega, addressMode: .inh)
        
        #expect(cpu.A == 0x01)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
        #expect(cpu.readCC(.carry) == true)
    }
    
    @Test func test_nega_0x80() async throws {
        let cpu = CPU.create(ram: [], acca: 0x80)
        
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .nega, addressMode: .inh)
        
        #expect(cpu.A == 0x80)
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == true)
        #expect(cpu.readCC(.carry) == true)
    }
}
