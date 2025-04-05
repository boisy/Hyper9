import Foundation

extension Turbo9CPU {
    /// Unconditional jump.
    ///
    /// ```
    /// PC’ ← EA
    /// ```
    ///
    /// Program control is transferred to the effective address.
    ///
    /// Addressing Modes:
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes: Not affected.
    func jmp(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        PC = addressAbsolute
        return false
    }

    /// Unconditional jump to subroutine.
    ///
    /// Program control is transferred to the effective address after storing the return address on the hardware stack. A `RTS` instruction should be the last executed instruction of the subroutine.
    ///
    /// ```
    /// SP' ← SP-1, (SP) ← PCL
    /// SP' ← SP-1, (SP) ← PCH
    /// PC' ←EA
    /// ```d
    ///
    /// Addressing Modes:
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes: Not affected.
    func jsr(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        pushToS(word: PC)
        PC = addressAbsolute

        return false
    }
}
