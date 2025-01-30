import Testing
@testable import SwiftTurbo9

struct TestABX {
    @Test func test_A_plus_X() async throws {
        let b = 23
        let x = 4096
        let cpu = CPU.create(ram: [0x00])
        cpu.setupAddressing(using: .inh)
        
        cpu.B = UInt8(b)
        cpu.X = UInt16(x)
        try cpu.perform(instruction: .abx, addressMode: .inh)
        
        #expect(cpu.X == b + x)
    }
    
    @Test func test_A_plus_X_rollover() async throws {
        let b = 0x20
        let x = 0xFFF0
        let cpu = CPU.create(ram: [0x00])
        cpu.setupAddressing(using: .inh)
        
        cpu.B = UInt8(b)
        cpu.X = UInt16(x)
        try cpu.perform(instruction: .abx, addressMode: .inh)
        
        #expect(cpu.X == 0x10)
    }
}
