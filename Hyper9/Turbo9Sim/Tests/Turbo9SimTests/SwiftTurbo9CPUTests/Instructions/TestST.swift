import Testing
@testable import Turbo9Sim

struct TestSTA {
    @Test func test_sta_negative() async throws {
        let cpu = Turbo9CPU.create(ram: [0x00])
        cpu.setupAddressing(using: .imm8)
        
        cpu.A = 0xFA
        try cpu.perform(instruction: .sta, addressMode: .imm8)
        
        #expect(cpu.readByte(0) == 0xFA)
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.zero) == false)
    }
    
    @Test func test_sta_positive() async throws {
        let cpu = Turbo9CPU.create(ram: [0x00])
        cpu.setupAddressing(using: .imm8)
        
        cpu.A = 0x7A
        try cpu.perform(instruction: .sta, addressMode: .imm8)
        
        #expect(cpu.readByte(0) == 0x7A)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
    }
    
    @Test func test_sta_zero() async throws {
        let cpu = Turbo9CPU.create(ram: [0x11])
        cpu.setupAddressing(using: .imm8)
        
        cpu.A = 0x00
        try cpu.perform(instruction: .sta, addressMode: .imm8)
        
        #expect(cpu.readByte(0) == 0x00)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == true)
    }
}

struct TestSTD {
    @Test func test_std_negative() async throws {
        let cpu = Turbo9CPU.create(ram: [0x11, 0x22])
        cpu.setupAddressing(using: .imm16)
        
        cpu.D = 0xF11F
        try cpu.perform(instruction: .std, addressMode: .imm16)
        
        #expect(cpu.readWord(0) == 0xF11F)
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.zero) == false)
    }
    
    @Test func test_std_positive() async throws {
        let cpu = Turbo9CPU.create(ram: [0x00, 0x00])
        cpu.setupAddressing(using: .imm16)
        
        cpu.D = 0x7118
        try cpu.perform(instruction: .std, addressMode: .imm16)
        
        #expect(cpu.readWord(0) == 0x7118)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
    }
    
    @Test func test_std_zero() async throws {
        let cpu = Turbo9CPU.create(ram: [0x11, 0x22])
        cpu.setupAddressing(using: .imm16)
        
        cpu.D = 0x0000
        try cpu.perform(instruction: .sta, addressMode: .imm16)
        
        #expect(cpu.readByte(0) == 0x0000)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == true)
    }
}
