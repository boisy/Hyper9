import Foundation

extension CPU {
    private func ld16(addressMode: AddressMode, register: inout UInt16) {
        switch addressMode {
        case .imm16:
            register = readWord(addressAbsolute)
        default:
            register = readWord(addressAbsolute)
        }

        setZeroFlag(using: register)
        setNegativeFlag(using: register)
    }


    private func ld8(addressMode: AddressMode, register: inout UInt8) {
        switch addressMode {
        case .imm8:
            register = readByte(addressAbsolute)
        default:
            register = readByte(addressAbsolute)
        }

        setZeroFlag(using: register)
        setNegativeFlag(using: register)
    }

    /// Load data into accumulator `A`.
    ///
    /// ```
    /// R' ← M
    /// ```
    ///
    /// This instruction loads the contents of memory location M into the designated register.
    ///
    /// Addressing Modes:    Immediate
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition Codes:
    /// - H    -    Not affected.
    /// - N    -    Set if the loaded data is negative; cleared otherwise.
    /// - Z    -    Set if the loaded data is zero; cleared otherwise.
    /// - V    -    Always cleared.
    /// - C    -    Not affected.
    func lda(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        ld8(addressMode: addressMode, register: &A)

        return false
    }

    /// Load data into accumulator `B`.
    ///
    /// ```
    /// R' ← M
    /// ```
    ///
    /// This instruction loads the contents of memory location M into the designated register.
    ///
    /// Addressing Modes:
    /// - Immediate
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition Codes:
    /// - H    -    Not affected.
    /// - N    -    Set if the loaded data is negative; cleared otherwise.
    /// - Z    -    Set if the loaded data is zero; cleared otherwise.
    /// - V    -    Always cleared.
    /// - C    -    Not affected.
    func ldb(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        ld8(addressMode: addressMode, register: &B)

        return false
    }

    /// Load data into accumulator `D`.
    ///
    /// ```
    /// R' ← M:M+1
    /// ```
    ///
    /// This instruction loads the contents of memory location M into the designated register.
    ///
    /// Addressing Modes:
    /// - Immediate
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition Codes:
    /// - H    -    Not affected.
    /// - N    -    Set if the loaded data is negative; cleared otherwise.
    /// - Z    -    Set if the loaded data is zero; cleared otherwise.
    /// - V    -    Always cleared.
    /// - C    -    Not affected.
    func ldd(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        ld16(addressMode: addressMode, register: &D)

        return false
    }

    /// Load data into register `X`.
    ///
    /// ```
    /// R' ← M:M+1
    /// ```
    ///
    /// This instruction loads the contents of memory location M into the designated register.
    ///
    /// Addressing Modes:
    /// - Immediate
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition Codes:
    /// - H    -    Not affected.
    /// - N    -    Set if the loaded data is negative; cleared otherwise.
    /// - Z    -    Set if the loaded data is zero; cleared otherwise.
    /// - V    -    Always cleared.
    /// - C    -    Not affected.
    func ldx(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        ld16(addressMode: addressMode, register: &X)

        return false
    }

    /// Load data into register `Y`.
    ///
    /// ```
    /// R' ← M:M+1
    /// ```
    ///
    /// This instruction loads the contents of memory location M into the designated register.
    ///
    /// Addressing Modes:
    /// - Immediate
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition Codes:
    /// - H    -    Not affected.
    /// - N    -    Set if the loaded data is negative; cleared otherwise.
    /// - Z    -    Set if the loaded data is zero; cleared otherwise.
    /// - V    -    Always cleared.
    /// - C    -    Not affected.
    func ldy(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        ld16(addressMode: addressMode, register: &Y)

        return false
    }

    /// Load data into register `U`.
    ///
    /// ```
    /// R' ← M:M+1
    /// ```
    ///
    /// This instruction loads the contents of memory location M into the designated register.
    ///
    /// Addressing Modes:
    /// - Immediate
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition Codes:
    /// - H    -    Not affected.
    /// - N    -    Set if the loaded data is negative; cleared otherwise.
    /// - Z    -    Set if the loaded data is zero; cleared otherwise.
    /// - V    -    Always cleared.
    /// - C    -    Not affected.
    func ldu(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        ld16(addressMode: addressMode, register: &U)

        return false
    }

    /// Load data into register `S`.
    ///
    /// ```
    /// R' ← M:M+1
    /// ```
    ///
    /// This instruction loads the contents of memory location M into the designated register.
    ///
    /// Addressing Modes:
    /// - Immediate
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition Codes:
    /// - H    -    Not affected.
    /// - N    -    Set if the loaded data is negative; cleared otherwise.
    /// - Z    -    Set if the loaded data is zero; cleared otherwise.
    /// - V    -    Always cleared.
    /// - C    -    Not affected.
    func lds(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        ld16(addressMode: addressMode, register: &S)

        return false
    }
}
