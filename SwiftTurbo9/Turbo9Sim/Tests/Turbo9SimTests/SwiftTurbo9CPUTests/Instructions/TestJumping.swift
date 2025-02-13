import Testing
@testable import Turbo9Sim

struct TestJMP {
    @Test func test_jmp() async throws {
        let cpu = CPU.create(ram: [0x00, 0x02])
        cpu.setupAddressing(using: .ext)
        
        try cpu.perform(instruction: .jmp, addressMode: .ext)
        
        #expect(cpu.PC == 0x02)
    }
}

struct TestJSR {
    @Test func test_jsr() async throws {
        let cpu = CPU.create(ram: [0x00, 0x00, 0x02, 0x00, 0x00], stackPointer: 0x0005)
        cpu.PC = 0x0001
        cpu.setupAddressing(using: .ext)
        
        try cpu.perform(instruction: .jsr, addressMode: .ext)
        
        #expect(cpu.PC == 0x02)
        #expect(cpu.readWord(0x0003) == 0x0003)
    }
}
