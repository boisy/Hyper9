import Testing
@testable import Turbo9Sim

struct TestDisassembler {
    @Test func test_it_disassembles() {
        let disassembler = Disassembler(program: [0x20, 0x09, 0x00, 0x20, 0x0C, 0x00, 0x20, 0x12, 0x00, 0xA2, 0x00, 0x60, 0xE8, 0xE0, 0x05, 0xD0, 0xFB, 0x60, 0x00])

        let code = disassembler.disassemble()
    }
}
