import Foundation

extension Turbo9CPU {
    /// Push registers onto the system stack.
    ///
    /// All, some, or none of the processor registers are pushed onto the user stack (with the exception of the user stack pointer itself).
    ///
    /// A single register may be placed on the stack with the condition codes set by doing an autodecrement store onto the stack (example: `STX ,--S`).
    ///
    /// The stack push order is as follows: PC, U, Y, X, DP, B, A, CC.
    ///
    /// Addressing Mode:
    ///  - Immediate
    ///
    /// Condition codes: Not affected.
    func pshs(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        let postByte = readByte(addressAbsolute)
        if postByte & 0x80 == 0x80 {
            pushToS(word: PC)
        }
        if postByte & 0x40 == 0x40 {
            pushToS(word: U)
        }
        if postByte & 0x20 == 0x20 {
            pushToS(word: Y)
        }
        if postByte & 0x10 == 0x10 {
            pushToS(word: X)
        }
        if postByte & 0x08 == 0x08 {
            pushToS(byte: DP)
        }
        if postByte & 0x04 == 0x04 {
            pushToS(byte: B)
        }
        if postByte & 0x02 == 0x02 {
            pushToS(byte: A)
        }
        if postByte & 0x01 == 0x01 {
            pushToS(byte: CC)
        }

        return false
    }

    /// Push registers onto the user stack.
    ///
    /// All, some, or none of the processor registers are pushed onto the user stack (with the exception of the user stack pointer itself).
    ///
    /// A single register may be placed on the stack with the condition codes set by doing an autodecrement store onto the stack (example: `STX ,--U`).
    ///
    /// The stack push order is as follows: PC, S, Y, X, DP, B, A, CC.
    ///
    /// Addressing Mode:
    ///  - Immediate
    ///
    /// Condition codes: Not affected.
    func pshu(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        let postByte = readByte(addressAbsolute)
        if postByte & 0x80 == 0x80 {
            pushToU(word: PC)
        }
        if postByte & 0x40 == 0x40 {
            pushToU(word: S)
        }
        if postByte & 0x20 == 0x20 {
            pushToU(word: Y)
        }
        if postByte & 0x10 == 0x10 {
            pushToU(word: X)
        }
        if postByte & 0x08 == 0x08 {
            pushToU(byte: DP)
        }
        if postByte & 0x04 == 0x04 {
            pushToU(byte: B)
        }
        if postByte & 0x02 == 0x02 {
            pushToU(byte: A)
        }
        if postByte & 0x01 == 0x01 {
            pushToU(byte: CC)
        }

        return false
    }

    /// Pull registers off the system stack.
    ///
    /// All, some, or none of the processor registers are pulled from the hardware stack (with the exception of the hardware stack pointer itself).
    ///
    /// A single register may be pulled from the stack with condition codes set by doing an autoincrement load from the stack (example: `LDX ,S++`).
    ///
    /// The stack pull order is as follows: CC, A, B, DP, X, Y, U.
    ///
    /// Addressing Mode:
    ///  - Immediate
    ///
    /// Condition codes: May be pulled from stack; not affected otherwise.
    func puls(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        let postByte = readByte(addressAbsolute)
        if postByte & 0x01 == 0x01 {
            CC = pullByteFromS()
        }
        if postByte & 0x02 == 0x02 {
            A = pullByteFromS()
        }
        if postByte & 0x04 == 0x04 {
            B = pullByteFromS()
        }
        if postByte & 0x08 == 0x08 {
            DP = pullByteFromS()
        }
        if postByte & 0x10 == 0x10 {
            X = pullWordFromS()
        }
        if postByte & 0x20 == 0x20 {
            Y = pullWordFromS()
        }
        if postByte & 0x40 == 0x40 {
            U = pullWordFromS()
        }
        if postByte & 0x80 == 0x80 {
            PC = pullWordFromS()
        }

        return false
    }

    /// Pull registers off the user stack.
    ///
    /// All, some, or none of the processor registers are pulled from the hardware stack (with the exception of the hardware stack pointer itself).
    ///
    /// A single register may be pulled from the stack with condition codes set by doing an autoincrement load from the stack (example: `LDX ,U++`).
    ///
    /// The stack pull order is as follows: CC, A, B, DP, X, Y, S.
    ///
    /// Addressing Mode:
    ///  - Immediate
    ///
    /// Condition codes: May be pulled from stack; not affected otherwise.
    func pulu(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        let postByte = readByte(addressAbsolute)
        if postByte & 0x01 == 0x01 {
            CC = pullByteFromU()
        }
        if postByte & 0x02 == 0x02 {
            A = pullByteFromU()
        }
        if postByte & 0x04 == 0x04 {
            B = pullByteFromU()
        }
        if postByte & 0x08 == 0x08 {
            DP = pullByteFromU()
        }
        if postByte & 0x10 == 0x10 {
            X = pullWordFromU()
        }
        if postByte & 0x20 == 0x20 {
            Y = pullWordFromU()
        }
        if postByte & 0x40 == 0x40 {
            S = pullWordFromU()
        }
        if postByte & 0x80 == 0x80 {
            PC = pullWordFromU()
        }

        return false
    }
}
