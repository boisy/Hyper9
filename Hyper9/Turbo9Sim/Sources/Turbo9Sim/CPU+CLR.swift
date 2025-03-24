import Foundation

extension Turbo9CPU {
    private func clr(addressMode: AddressMode, register: inout UInt8) -> ShouldIncludeExtraClockCycles {
        if addressMode == .inh {
            register = 0
        } else {
            writeByte(addressAbsolute, data: 0)
        }

        setCC(.negative, false)
        setCC(.zero, true)
        setCC(.overflow, false)
        setCC(.carry, false)

        return false
    }

    /// Load zero into accumulator `A`.
    ///
    /// Clears accumulator `A`.
    ///
    /// Addressing modes:
    /// - Inherent
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// H    -    Not affected.
    /// N    -    Always cleared.
    /// Z    -    Always set.
    /// V    -    Always cleared.
    /// C    -    Always cleared.
    func clra(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return clr(addressMode: addressMode, register: &A)
    }

    /// Load zero into accumulator `B`.
    ///
    /// Clears accumulator `B`.
    ///
    /// Addressing modes:
    /// - Inherent
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// H    -    Not affected.
    /// N    -    Always cleared.
    /// Z    -    Always set.
    /// V    -    Always cleared.
    /// C    -    Always cleared.
    func clrb(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return clr(addressMode: addressMode, register: &B)
    }

    /// Load zero into memory.
    ///
    /// Clears memory location.
    ///
    /// Addressing modes:
    /// - Inherent
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// H    -    Not affected.
    /// N    -    Always cleared.
    /// Z    -    Always set.
    /// V    -    Always cleared.
    /// C    -    Always cleared.
    func clr(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return clr(addressMode: addressMode, register: &B)
    }
}
