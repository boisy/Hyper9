import Testing
@testable import SwiftTurbo9

struct TestLDAB {
    @Test func test_A_it_loads_memory() async throws {
        let cpu = CPU.create(ram: [0x0F])
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .lda, addressMode: .imm8)
        
        #expect(cpu.A == 0x0F)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.negative) == false)
    }
    
    @Test func test_B_it_loads_memory() async throws {
        let cpu = CPU.create(ram: [0x0F])
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .ldb, addressMode: .imm8)
        
        #expect(cpu.B == 0x0F)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.negative) == false)
    }
    
    @Test func test_A_it_sets_zero_flag() async throws {
        let cpu = CPU.create(ram: [0x00])
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .lda, addressMode: .imm8)
        
        #expect(cpu.A == 0x00)
        #expect(cpu.readCC(.zero) == true)
        #expect(cpu.readCC(.negative) == false)
    }
    
    @Test func test_B_it_sets_zero_flag() async throws {
        let cpu = CPU.create(ram: [0x00])
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .ldb, addressMode: .imm8)
        
        #expect(cpu.B == 0x00)
        #expect(cpu.readCC(.zero) == true)
        #expect(cpu.readCC(.negative) == false)
    }
    
    @Test func test_A_it_sets_negative_flag() async throws {
        let cpu = CPU.create(ram: [0xF0])
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .lda, addressMode: .imm8)
        
        #expect(cpu.A == 0xF0)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.negative) == true)
    }
    
    @Test func test_B_it_sets_negative_flag() async throws {
        let cpu = CPU.create(ram: [0xF0])
        cpu.setupAddressing(using: .imm8)

        try cpu.perform(instruction: .ldb, addressMode: .imm8)

        #expect(cpu.B == 0xF0)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.negative) == true)
    }
}

struct TestLDD {
    @Test func test_D_immediate() async throws {
        let cpu = CPU.create(ram: [0x0F, 0x30])
        cpu.setupAddressing(using: .imm16)
        
        try cpu.perform(instruction: .ldd, addressMode: .imm16)
        
        #expect(cpu.D == 0x0F30)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.negative) == false)
    }
}
