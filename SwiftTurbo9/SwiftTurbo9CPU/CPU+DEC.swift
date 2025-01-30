import Foundation

extension CPU {
    private func decrement(addressMode: AddressMode, register: inout UInt8) -> ShouldIncludeExtraClockCycles {
        var value : UInt8

        if addressMode == .inh {
            value = register
        } else {
            value = readByte(addressAbsolute)
        }

        let decremented = perform(.dec, on: value)

        if addressMode == .inh {
            register = decremented
        } else {
            writeByte(addressAbsolute, data: decremented)
        }
        
        setCC(.overflow, value == 0x80)

        return false
    }

    /// Decrement accumulator `A`.
    ///
    /// ```
    /// r’ ←r + 1
    /// ```
    ///
    /// This instruction subtracts one from the operand. The carry bit is not affected, thus allowing this instruction to be used as a loop counter in multiple-precision computations. When operating on unsigned values, only `BEQ` and `BNE` branches can be expected to behave consistently. When operating on twos complement values, all signed branches are available.

    ///
    /// Addressing modes:
    /// - Inherent
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// - H    -    Not affected.
    /// - N    -    Set if the result is negative; cleared otherwise.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Set if the original operand was 10000000; cleared otherwise.
    /// - C    -    Not affected.
    func deca(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return decrement(addressMode: addressMode, register: &A)
    }

    /// Decrement accumulator `B`.
    ///
    /// ```
    /// r’ ←r + 1
    /// ```
    ///
    /// This instruction subtracts one from the operand. The carry bit is not affected, thus allowing this instruction to be used as a loop counter in multiple-precision computations. When operating on unsigned values, only `BEQ` and `BNE` branches can be expected to behave consistently. When operating on twos complement values, all signed branches are available.

    ///
    /// Addressing modes:
    /// - Inherent
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// - H    -    Not affected.
    /// - N    -    Set if the result is negative; cleared otherwise.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Set if the original operand was 10000000; cleared otherwise.
    /// - C    -    Not affected.
    func decb(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return decrement(addressMode: addressMode, register: &B)
    }

    /// Decrement a byte in memory.
    ///
    /// ```
    /// (M)’ ← (M) - 1
    /// ```
    ///
    /// This instruction subtracts one from the operand. The carry bit is not affected, thus allowing this instruction to be used as a loop counter in multiple-precision computations. When operating on unsigned values, only `BEQ` and `BNE` branches can be expected to behave consistently. When operating on twos complement values, all signed branches are available.

    ///
    /// Addressing modes:
    /// - Inherent
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// - H    -    Not affected.
    /// - N    -    Set if the result is negative; cleared otherwise.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Set if the original operand was 10000000; cleared otherwise.
    /// - C    -    Not affected.
    func dec(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return decrement(addressMode: addressMode, register: &B)
    }
}
