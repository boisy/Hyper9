import Foundation

extension Turbo9CPU {
    /// Sign extend the 8-bit value in accumulator `B` to a 16-bit value in D.
    ///
    /// This instruction transforms a twos complement 8-bit value in accumulator `B` into a twos complement 16-bit value in the `D` accumulator.
    ///
    /// ```
    /// If bit seven of `B` is set then `A`' ← 0xFF else `A`' ← 0x00
    /// ```d
    ///
    /// Addressing Modes:
    /// - Inherent
    ///
    /// Condition codes:
    /// - H    -    Not affected.
    /// - N    -    Set if the result is negative; cleared otherwise.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Not affected.
    /// - C    -    Not affected.
    func sex(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        var upper : UInt8 = 0
        let lower = B
        if (lower & 0x80) == 0x80 {
            upper = 0xFF
        }
        D = .createWord(highByte: upper, lowByte: lower)
        setNegativeFlag(using: D)
        setZeroFlag(using: D)

        return true
    }
}
