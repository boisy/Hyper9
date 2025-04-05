import Testing
@testable import Turbo9Sim

struct TestEXG {
    @Test func test_exg_a_b() async throws {
        let cpu = Turbo9CPU.create(ram: [0x89], acca: 0x0F, accb: 0xA1)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .exg, addressMode: .imm8)
        
        #expect(cpu.A == 0xA1)
        #expect(cpu.B == 0x0F)
    }
    
    @Test func test_exg_x_y() async throws {
        let cpu = Turbo9CPU.create(ram: [0x12], X: 0xDEAD, Y: 0xBEEF)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .exg, addressMode: .imm8)
        
        #expect(cpu.X == 0xBEEF)
        #expect(cpu.Y == 0xDEAD)
    }
    
    @Test func test_exg_u_s() async throws {
        let cpu = Turbo9CPU.create(ram: [0x34], stackPointer: 0xBEEF, U: 0xDEAD)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .exg, addressMode: .imm8)
        
        #expect(cpu.U == 0xBEEF)
        #expect(cpu.S == 0xDEAD)
    }

    /*
    @Test func test_exg_pc_d() async throws {
        let cpu = CPU.create(ram: [0x50], acca: 0xBE, accb: 0xEF, pc: 0x0000)
        cpu.setupAddressing(using: .imm8)
        
        try cpu.perform(instruction: .exg, addressMode: .imm8)
        
        #expect(cpu.PC == 0xBEEF)
        #expect(cpu.D == 0x0000)
    }
     */
    
}
