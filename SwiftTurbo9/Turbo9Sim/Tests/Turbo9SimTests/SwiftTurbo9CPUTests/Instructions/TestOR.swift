import Testing
@testable import Turbo9Sim

struct TestORA {
    @Test func test_ora_immediate() async throws {
        let storedByte : UInt8 = 0x11
        let accumulator : UInt8 = 0x10
        let cpu = CPU.create(ram: [storedByte], acca: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .ora, addressMode: .imm8)
        
        #expect(cpu.A == storedByte | accumulator)
        
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
    }
}

struct TestORB {
    @Test func test_orb_immediate() async throws {
        let storedByte : UInt8 = 0x81
        let accumulator : UInt8 = 0x10
        let cpu = CPU.create(ram: [storedByte], accb: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .orb, addressMode: .imm8)
        
        #expect(cpu.B == storedByte | accumulator)
        
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
    }
}

struct TestORCC {
    @Test func test_orcc_immediate_1() async throws {
        let storedByte : UInt8 = 0xF0
        let cpu = CPU.create(ram: [storedByte])
        
        cpu.setupAddressing(using: .imm8)

        cpu.setCC(.entire, true)
        cpu.setCC(.firq, true)
        cpu.setCC(.halfcarry, true)
        cpu.setCC(.irq, true)
        cpu.setCC(.negative, false)
        cpu.setCC(.zero, false)
        cpu.setCC(.overflow, false)
        cpu.setCC(.carry, false)
        
        try cpu.perform(instruction: .orcc, addressMode: .imm8)
        
        #expect(cpu.readCC(.entire) == true)
        #expect(cpu.readCC(.firq) == true)
        #expect(cpu.readCC(.halfcarry) == true)
        #expect(cpu.readCC(.irq) == true)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
        #expect(cpu.readCC(.carry) == false)
    }
    
    @Test func test_orcc_immediate_2() async throws {
        let storedByte : UInt8 = 0x18
        let cpu = CPU.create(ram: [storedByte])
        
        cpu.setupAddressing(using: .imm8)

        cpu.setCC(.entire, true)
        cpu.setCC(.firq, true)
        cpu.setCC(.halfcarry, true)
        cpu.setCC(.irq, true)
        cpu.setCC(.negative, true)
        cpu.setCC(.zero, true)
        cpu.setCC(.overflow, true)
        cpu.setCC(.carry, true)
        
        try cpu.perform(instruction: .orcc, addressMode: .imm8)
        
        #expect(cpu.readCC(.entire) == true)
        #expect(cpu.readCC(.firq) == true)
        #expect(cpu.readCC(.halfcarry) == true)
        #expect(cpu.readCC(.irq) == true)
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.zero) == true)
        #expect(cpu.readCC(.overflow) == true)
        #expect(cpu.readCC(.carry) == true)
    }
}
