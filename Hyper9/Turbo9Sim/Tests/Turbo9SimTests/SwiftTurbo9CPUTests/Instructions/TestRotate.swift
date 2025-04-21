import Testing
@testable import Turbo9Sim

struct TestROLA {
    @Test func test_rola_carry_set() async throws {
        let accumulator : UInt8 = 0x10
        let cpu = Turbo9CPU.create(ram: [0], acca: accumulator)
        cpu.setupAddressing(using: .inh)
        
        cpu.setCC(.carry, true)
        try cpu.perform(instruction: .rola, addressMode: .inh)
        
        #expect(cpu.A == (accumulator << 1) | 0x01)
        
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
        #expect(cpu.readCC(.carry) == false)
    }
    
    @Test func test_rola_carry_clear() async throws {
        let accumulator : UInt8 = 0x80
        let cpu = Turbo9CPU.create(ram: [0], acca: accumulator)
        cpu.setupAddressing(using: .inh)
        
        cpu.setCC(.carry, false)
        try cpu.perform(instruction: .rola, addressMode: .inh)
        
        #expect(cpu.A == accumulator << 1)

        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == true)
        #expect(cpu.readCC(.overflow) == true)
        #expect(cpu.readCC(.carry) == true)
    }
}

struct TestRORA {
    @Test func test_rora_carry_clear() async throws {
        let accumulator : UInt8 = 0x10
        let cpu = Turbo9CPU.create(ram: [0], acca: accumulator)
        cpu.setupAddressing(using: .inh)
        
        cpu.setCC(.carry, true)
        try cpu.perform(instruction: .rora, addressMode: .inh)
        
        #expect(cpu.A == ((accumulator >> 1) | 0x80))
        
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.carry) == false)
    }
    
    @Test func test_rora_zero_false() async throws {
        let accumulator : UInt8 = 0x80
        let cpu = Turbo9CPU.create(ram: [0], acca: accumulator)
        cpu.setupAddressing(using: .inh)
        
        cpu.setCC(.carry, false)
        try cpu.perform(instruction: .rora, addressMode: .inh)
        
        #expect(cpu.A == accumulator >> 1)
        #expect(cpu.readCC(.zero) == false)
    }
    
    @Test func test_rora_carry_true() async throws {
        let accumulator : UInt8 = 0x01
        let cpu = Turbo9CPU.create(ram: [0], acca: accumulator)
        cpu.setupAddressing(using: .inh)
        
        cpu.setCC(.carry, true)
        try cpu.perform(instruction: .rora, addressMode: .inh)
        
        #expect(cpu.A == (accumulator >> 1) | 0x80)
        #expect(cpu.readCC(.carry) == true)
    }
}
