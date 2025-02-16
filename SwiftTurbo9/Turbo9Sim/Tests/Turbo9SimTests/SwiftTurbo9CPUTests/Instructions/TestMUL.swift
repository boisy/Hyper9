import Testing
@testable import Turbo9Sim

struct TestMUL {
    @Test func test_multiply_negative_result() async throws {
        let cpu = Turbo9CPU.create(ram: [0x00])
        cpu.setupAddressing(using: .imm8)
        
        cpu.A = 128
        cpu.B = 1
        try cpu.perform(instruction: .mul, addressMode: .imm8)
        
        #expect(cpu.A == 0xFF)
        #expect(cpu.B == 0x80)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.carry) == true)
    }

    @Test func test_multiply_positive_result() async throws {
        let cpu = Turbo9CPU.create(ram: [0x00])
        cpu.setupAddressing(using: .imm8)
        
        cpu.A = 3
        cpu.B = 4
        try cpu.perform(instruction: .mul, addressMode: .imm8)
        
        #expect(cpu.A == 0x00)
        #expect(cpu.B == 0x0C)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.carry) == false)
    }
    
    @Test func test_multiply_zero_result() async throws {
        let cpu = Turbo9CPU.create(ram: [0x00])
        cpu.setupAddressing(using: .imm8)
        
        cpu.A = 0
        cpu.B = 4
        try cpu.perform(instruction: .mul, addressMode: .imm8)
        
        #expect(cpu.A == 0x00)
        #expect(cpu.B == 0x00)
        #expect(cpu.readCC(.zero) == true)
        #expect(cpu.readCC(.carry) == false)
    }
}
