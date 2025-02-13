import Testing
@testable import Turbo9Sim

struct TestRTI {
    @Test func test_pshs_cc() async throws {
        let cpu = CPU.create(ram: [0x80, 0xAA, 0xBB, 0xDD, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0xEE, 0xAA])
        cpu.CC = 0x40
        cpu.S = 0x00
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .rti, addressMode: .inh)
        
        #expect(cpu.S == 0x000C)
        #expect(cpu.A == 0xAA)
        #expect(cpu.B == 0xBB)
        #expect(cpu.DP == 0xDD)
        #expect(cpu.X == 0x0102)
        #expect(cpu.Y == 0x0304)
        #expect(cpu.U == 0x0506)
        #expect(cpu.PC == 0xEEAA)
    }
}

struct TestRTS {
    @Test func test_pshs_cc() async throws {
        let cpu = CPU.create(ram: [0xAB, 0xCD])
        cpu.setupAddressing(using: .inh)
        
        cpu.S = 0x0000
        try cpu.perform(instruction: .rts, addressMode: .inh)
        
        #expect(cpu.PC == 0xABCD)
    }
}
