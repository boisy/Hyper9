import Foundation

extension CPU {
    private func complement(addressMode: AddressMode, register: inout UInt8) -> ShouldIncludeExtraClockCycles {
        var value: UInt8

        if addressMode == .inh {
            value = register
        } else {
            value = readByte(addressAbsolute)
        }

        value = ~value

        setNegativeFlag(using: value)
        setZeroFlag(using: value)
        setCC(.overflow, false)
        setCC(.carry, true)

        if addressMode == .inh {
            register = value
        } else {
            writeByte(addressAbsolute, data: value)
        }

        return false
    }

    /// Complement accumulator `A`.
    ///
    /// This instruction replaces the contents of the accumulator with its logical complement. When operating on unsigned values, only `BEQ` and `BNE` branches can be expected to behave properly following a `COM` instruction. When operating on twos complement values, all signed branches are available.
    ///
    /// Addressing modes:
    /// - Inherent
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// H    -    Not affected.
    /// N    -    Set if the result is negative; cleared otherwise.
    /// Z    -    Set if the result is zero; cleared otherwise.
    /// V    -    Always cleared.
    /// C    -    Always set.
    func coma(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return complement(addressMode: addressMode, register: &A)
    }

    /// Complement accumulator `B`.
    ///
    /// This instruction replaces the contents of the accumulator with its logical complement. When operating on unsigned values, only `BEQ` and `BNE` branches can be expected to behave properly following a `COM` instruction. When operating on twos complement values, all signed branches are available.
    ///
    /// Addressing modes:
    /// - Inherent
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// H    -    Not affected.
    /// N    -    Set if the result is negative; cleared otherwise.
    /// Z    -    Set if the result is zero; cleared otherwise.
    /// V    -    Always cleared.
    /// C    -    Always set.
    func comb(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return complement(addressMode: addressMode, register: &B)
    }

    /// Complement a byte in memory.
    ///
    /// This instruction replaces the contents of the accumulator with its logical complement. When operating on unsigned values, only `BEQ` and `BNE` branches can be expected to behave properly following a `COM` instruction. When operating on twos complement values, all signed branches are available.
    ///
    /// Addressing modes:
    /// - Inherent
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// H    -    Not affected.
    /// N    -    Set if the result is negative; cleared otherwise.
    /// Z    -    Set if the result is zero; cleared otherwise.
    /// V    -    Always cleared.
    /// C    -    Always set.
    func com(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return complement(addressMode: addressMode, register: &B)
    }
}
