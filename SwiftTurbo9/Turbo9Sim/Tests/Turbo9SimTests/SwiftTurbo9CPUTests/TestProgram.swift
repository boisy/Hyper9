import Testing
@testable import Turbo9Sim

struct TestProgram {
    func test_nop() throws {
        let code: [UInt8] = [0x21, 0x3D, 0x20, 0xFC, 0x00]
        let cpu = CPU.create(ram: .createRam(withProgram: code, loadAddress: 0xE000))
        try cpu.reset()
//        cpu.run()
    }
}
