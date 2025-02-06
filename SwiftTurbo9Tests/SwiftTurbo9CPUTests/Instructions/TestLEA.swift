import Testing
@testable import Turbo9Sim

struct TestLEAX {
    @Test func test_leax_8bit_constant_offset_from_PC() async throws {
        let cpu = CPU.create(ram: [0x8C, 0x05], X: 0x0000)
        cpu.setupAddressing(using: .ind)
        
        try cpu.perform(instruction: .leax, addressMode: .ind)
        
        #expect(cpu.X == 0x07)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.negative) == false)
    }
}
