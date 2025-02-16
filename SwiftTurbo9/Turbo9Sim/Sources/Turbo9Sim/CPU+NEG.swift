import Foundation

extension Turbo9CPU {
    private func negate(addressMode: AddressMode, register: inout UInt8) -> ShouldIncludeExtraClockCycles {
        var value: UInt8

        if addressMode == .inh {
            value = register
        } else {
            value = readByte(addressAbsolute)
        }

        setCC(.overflow, value == 0x80)
        setCC(.carry, value != 0x00)
        
        value = 0 &- value

        setNegativeFlag(using: value)
        setZeroFlag(using: value)

        if addressMode == .inh {
            register = value
        } else {
            writeByte(addressAbsolute, data: value)
        }

        return false
    }

    /// Negate (twos-complement) accumulator `A`.
    ///
    /// ```
    /// r’ ← 0 - r
    /// ```
    ///
    /// This instruction replaces the operand with its twos complement. The `C` (carry) bit represents a borrow and is set to the inverse of the resulting binary carry. Note that $80 is replaced by itself and only in this case is the `V` (overflow) bit set. The value $00 is also replaced by itself, and only in this case is the `C` (carry) bit cleared.
    ///
    /// Addressing modes:
    /// - Inherent
    /// - Extended
    /// - Direct
    ///
    /// Condition codes:
    /// -  H    -    Not affected.
    /// -  N    -    Set if the result is negative; cleared otherwise.
    /// -  Z    -    Set if the result is zero; cleared otherwise.
    /// -  V    -    Set if the original operand was 10000000.
    /// -  C    -    Set if a borrow is generated; cleared otherwise.
    func nega(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return negate(addressMode: addressMode, register: &A)
    }

    /// Negate (twos-complement) accumulator `B`.
    ///
    /// ```
    /// r’ ← 0 - r
    /// ```
    ///
    /// This instruction replaces the operand with its twos complement. The `C` (carry) bit represents a borrow and is set to the inverse of the resulting binary carry. Note that $80 is replaced by itself and only in this case is the `V` (overflow) bit set. The value $00 is also replaced by itself, and only in this case is the `C` (carry) bit cleared.
    ///
    /// Addressing modes:
    /// - Inherent
    /// - Extended
    /// - Direct
    ///
    /// Condition codes:
    /// -  H    -    Not affected.
    /// -  N    -    Set if the result is negative; cleared otherwise.
    /// -  Z    -    Set if the result is zero; cleared otherwise.
    /// -  V    -    Set if the original operand was 10000000.
    /// -  C    -    Set if a borrow is generated; cleared otherwise.
    func negb(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return negate(addressMode: addressMode, register: &B)
    }

    /// Negate (twos complement) a byte in memory.
    ///
    /// ```
    /// (M)’ ← 0 - (M)
    /// ```
    ///
    /// This instruction replaces the operand with its twos complement. The `C` (carry) bit represents a borrow and is set to the inverse of the resulting binary carry. Note that $80 is replaced by itself and only in this case is the `V` (overflow) bit set. The value $00 is also replaced by itself, and only in this case is the `C` (carry) bit cleared.
    ///
    /// Addressing modes:
    /// - Inherent
    /// - Extended
    /// - Direct
    ///
    /// Condition codes:
    /// -  H    -    Not affected.
    /// -  N    -    Set if the result is negative; cleared otherwise.
    /// -  Z    -    Set if the result is zero; cleared otherwise.
    /// -  V    -    Set if the original operand was 10000000.
    /// -  C    -    Set if a borrow is generated; cleared otherwise.
    func neg(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return negate(addressMode: addressMode, register: &B)
    }
}
