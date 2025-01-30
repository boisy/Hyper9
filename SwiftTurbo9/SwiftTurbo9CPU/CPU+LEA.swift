import Foundation

extension CPU {
    /// Load effective address into `X`.
    ///
    /// ```
    /// r’ ← EA
    /// ```
    ///
    /// This instruction calculates the effective address from the indexed addressing mode and places the address in an indexable register.
    ///
    ///  Due to the order in which effective addresses are calculated internally, `LEAX ,X++` and `LEAX ,X+` do not add 2 and 1 (respectively) to the `X` register; but instead leave the `X` register unchanged. For the expected results, use the faster instructions `LEAX 2,X` and `LEAX 1,X`.
    ///
    /// Addressing Modes:
    /// - Indexed
    ///
    /// Condition Codes:
    /// - H    -    Not affected.
    /// - N    -    Not affected.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Not affected.
    /// - C    -    Not affected.
    func leax(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        X = addressAbsolute
        setZeroFlag(using: X)
        return false
    }

    /// Load effective address into `Y`.
    ///
    /// ```
    /// r’ ← EA
    /// ```
    ///
    /// This instruction calculates the effective address from the indexed addressing mode and places the address in an indexable register.
    ///
    ///  Due to the order in which effective addresses are calculated internally, `LEAY ,Y++` and `LEAY ,Y+` do not add 2 and 1 (respectively) to the `Y` register; but instead leave the `Y` register unchanged. For the expected results, use the faster instructions `LEAY 2,Y` and `LEAY 1,Y`.
    ///
    /// Addressing Modes:
    /// - Indexed
    ///
    /// Condition Codes:
    /// - H    -    Not affected.
    /// - N    -    Not affected.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Not affected.
    /// - C    -    Not affected.
    func leay(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        Y = addressAbsolute
        setZeroFlag(using: Y)
        return false
    }

    /// Load effective address into `U`.
    ///
    /// ```
    /// r’ ← EA
    /// ```
    ///
    /// This instruction calculates the effective address from the indexed addressing mode and places the address in an indexable register.
    ///
    ///  Due to the order in which effective addresses are calculated internally, `LEAU ,U++` and `LEAU ,U+` do not add 2 and 1 (respectively) to the `U` register; but instead leave the `U` register unchanged. For the expected results, use the faster instructions `LEAU 2,U` and `LEAU 1,U`.
    ///
    /// Addressing Modes:
    /// - Indexed
    ///
    /// Condition Codes:
    /// - H    -    Not affected.
    /// - N    -    Not affected.
    /// - Z    -    Not affected.
    /// - V    -    Not affected.
    /// - C    -    Not affected.
    func leau(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        U = addressAbsolute
        return false
    }

    /// Load effective address into `S`.
    ///
    /// ```
    /// r’ ← EA
    /// ```
    ///
    /// This instruction calculates the effective address from the indexed addressing mode and places the address in an indexable register.
    ///
    ///  Due to the order in which effective addresses are calculated internally, `LEAS SU++` and `LEAS ,S+` do not add 2 and 1 (respectively) to the `S` register; but instead leave the `S` register unchanged. For the expected results, use the faster instructions `LEAS 2,S` and `LEAS 1,S`.
    ///
    /// Addressing Modes:
    /// - Indexed
    ///
    /// Condition Codes:
    /// - H    -    Not affected.
    /// - N    -    Not affected.
    /// - Z    -    Not affected.
    /// - V    -    Not affected.
    /// - C    -    Not affected.
    func leas(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        S = addressAbsolute
        return false
    }
}
