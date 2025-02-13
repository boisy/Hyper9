import Foundation

extension CPU {
    private func test(addressMode: AddressMode, register: inout UInt8) -> ShouldIncludeExtraClockCycles {
        var value: UInt8 = 0
        if addressMode == .inh {
            value = register
        } else {
            value = readByte(addressAbsolute)
        }

        setNegativeFlag(using: value)
        setZeroFlag(using: value)
        setCC(.overflow, false)

        return false
    }

    /// Test value in accumulator `A`.
    ///
    /// Set the `N` (negative) and `Z` (zero) bits according to the contents of memory location M, and clear the `V` (overflow) bit. The `TST` instruction provides only minimum information when testing unsigned values; since no unsigned value is less than zero, `BLO` and `BLS` have no utility. While `BHI` could be used after `TST`, it provides exactly the same control as `BNE`, which is preferred. The signed branches are available.
    ///
    /// Addressing modes:
    /// - Inherent
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// - H    -    Undefined.
    /// - N    -    Set if the result is negative; cleared otherwise.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Always cleared.
    /// - C    -    Not affected.
    func tsta(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return test(addressMode: addressMode, register: &A)
    }

    /// Test value in accumulator `B`.
    ///
    /// Set the `N` (negative) and `Z` (zero) bits according to the contents of memory location M, and clear the `V` (overflow) bit. The `TST` instruction provides only minimum information when testing unsigned values; since no unsigned value is less than zero, `BLO` and `BLS` have no utility. While `BHI` could be used after `TST`, it provides exactly the same control as `BNE`, which is preferred. The signed branches are available.
    ///
    /// Addressing modes:
    /// - Inherent
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// - H    -    Undefined.
    /// - N    -    Set if the result is negative; cleared otherwise.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Always cleared.
    /// - C    -    Not affected.
    func tstb(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return test(addressMode: addressMode, register: &B)
    }

    /// Test value in memory byte.
    ///
    /// Set the `N` (negative) and `Z` (zero) bits according to the contents of memory location M, and clear the `V` (overflow) bit. The `TST` instruction provides only minimum information when testing unsigned values; since no unsigned value is less than zero, `BLO` and `BLS` have no utility. While `BHI` could be used after `TST`, it provides exactly the same control as `BNE`, which is preferred. The signed branches are available.
    ///
    /// Addressing modes:
    /// - Inherent
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// - H    -    Undefined.
    /// - N    -    Set if the result is negative; cleared otherwise.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Always cleared.
    /// - C    -    Not affected.
    func tst(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return test(addressMode: addressMode, register: &B)
    }
}
