@testable import Turbo9Sim

extension Turbo9CPU {
    static func create(
        ram: [UInt8],
        acca: UInt8 = 0x00,
        accb: UInt8 = 0x00,
        pc: UInt16 = 0x0000,
        stackPointer: UInt16 = 0x00FF,
        X: UInt16 = 0x0000,
        Y: UInt16 = 0x0000,
        U: UInt16 = 0x0000,
        DP: UInt8 = 0x00
    ) -> Turbo9CPU {
        Turbo9CPU(
            bus: Bus(memory: ram),
            pc: pc,
            stackPointer: stackPointer,
            A: acca,
            B: accb,
            X: X,
            Y: Y,
            U: U,
            DP: DP,
            flags: 0x00
        )
    }
}

