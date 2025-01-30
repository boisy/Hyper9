import Testing
@testable import SwiftTurbo9

struct TestANDA {
    @Test func test_anda_immediate() async throws {
        let storedByte : UInt8 = 0x11
        let accumulator : UInt8 = 0x10
        let cpu = CPU.create(ram: [storedByte], acca: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .anda, addressMode: .imm8)
        
        #expect(cpu.A == storedByte & accumulator)
        
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
    }
}

struct TestANDB {
    @Test func test_andb_immediate() async throws {
        let storedByte : UInt8 = 0x11
        let accumulator : UInt8 = 0x10
        let cpu = CPU.create(ram: [storedByte], accb: accumulator)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .andb, addressMode: .imm8)
        
        #expect(cpu.B == storedByte & accumulator)
        
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
    }
}

struct TestANDCC {
    @Test func test_andcc_immediate_1() async throws {
        let storedByte : UInt8 = 0xF0
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
        
        try cpu.perform(instruction: .andcc, addressMode: .imm8)
        
        #expect(cpu.readCC(.entire) == true)
        #expect(cpu.readCC(.firq) == true)
        #expect(cpu.readCC(.halfcarry) == true)
        #expect(cpu.readCC(.irq) == true)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
        #expect(cpu.readCC(.carry) == false)
    }
    
    @Test func test_andcc_immediate_2() async throws {
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
        
        try cpu.perform(instruction: .andcc, addressMode: .imm8)
        
        #expect(cpu.readCC(.entire) == false)
        #expect(cpu.readCC(.firq) == false)
        #expect(cpu.readCC(.halfcarry) == false)
        #expect(cpu.readCC(.irq) == true)
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
        #expect(cpu.readCC(.carry) == false)
    }
}
