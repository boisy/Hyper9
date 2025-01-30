import Testing
@testable import SwiftTurbo9

struct TestTSTA {
    @Test func test_tsta_negative() async throws {
        let cpu = CPU.create(ram: [])
        cpu.setupAddressing(using: .inh)
        
        cpu.A = 0xFA
        cpu.setCC(.overflow, true)
        try cpu.perform(instruction: .tsta, addressMode: .inh)
        
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
    }
    
    @Test func test_tsta_positive() async throws {
        let cpu = CPU.create(ram: [])
        cpu.setupAddressing(using: .inh)
        
        cpu.A = 0x3A
        cpu.setCC(.overflow, true)
        try cpu.perform(instruction: .tsta, addressMode: .inh)
        
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
    }
    
    @Test func test_tsta_zero() async throws {
        let cpu = CPU.create(ram: [])
        cpu.setupAddressing(using: .inh)
        
        cpu.A = 0x00
        cpu.setCC(.overflow, true)
        try cpu.perform(instruction: .tsta, addressMode: .inh)
        
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == true)
        #expect(cpu.readCC(.overflow) == false)
    }
}
