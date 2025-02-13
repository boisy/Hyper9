import Foundation

extension CPU {
    // Increment memory or accumulator.
    private func increment(addressMode: AddressMode, register: inout UInt8) -> ShouldIncludeExtraClockCycles {
        var value : UInt8

        if addressMode == .inh {
            value = register
        } else {
            value = readByte(addressAbsolute)
        }

        let incremented = perform(.inc, on: value)

        if addressMode == .inh {
            register = incremented
        } else {
            writeByte(addressAbsolute, data: incremented)
        }
        
        setCC(.overflow, value == 0x7F)

        return false
    }

    /// Increment accumulator `A`.
    ///
    /// ```
    /// r’ ←r + 1
    /// ```
    ///
    /// This instruction adds to the operand. The carry bit is not affected, thus allowing this instruction to be used as a loop counter in multiple-precision computations. When operating on unsigned values, only the `BEQ` and `BNE` branches can be expected to behave consistently. When operating on twos complement values, all signed branches are correctly available.
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
    /// - V    -    Set if the original operand was 01111111; cleared otherwise.
    /// - C    -    Not affected.
    func inca(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return increment(addressMode: addressMode, register: &A)
    }

    /// Increment accumulator `B`.
    ///
    /// ```
    /// r’ ←r + 1
    /// ```
    ///
    /// This instruction adds to the operand. The carry bit is not affected, thus allowing this instruction to be used as a loop counter in multiple-precision computations. When operating on unsigned values, only the `BEQ` and `BNE` branches can be expected to behave consistently. When operating on twos complement values, all signed branches are correctly available.
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
    func incb(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return increment(addressMode: addressMode, register: &B)
    }

    /// Increment memory byte.
    ///
    /// ```
    /// M' ← M + 1
    /// ```
    ///
    /// This instruction adds to the operand. The carry bit is not affected, thus allowing this instruction to be used as a loop counter in multiple-precision computations. When operating on unsigned values, only the `BEQ` and `BNE` branches can be expected to behave consistently. When operating on twos complement values, all signed branches are correctly available.
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
    func inc(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return increment(addressMode: addressMode, register: &B)
    }
}
