import Foundation

extension CPU {
    /// Store accumulator `A` to memory.
    ///
    /// ```
    /// M' ← R
    /// ```
    ///
    /// This instruction writes the contents of an 8-bit register into a memory location.
    ///
    /// Addressing Modes:
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
    func sta(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        writeByte(addressAbsolute, data: A)
        setNegativeFlag(using: A)
        setZeroFlag(using: A)
        return false
    }

    /// Store accumulator `B` to memory.
    ///
    /// ```
    /// M' ← R
    /// ```
    ///
    /// This instruction writes the contents of an 8-bit register into a memory location.
    ///
    /// Addressing Modes:
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
    func stb(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        writeByte(addressAbsolute, data: B)
        setNegativeFlag(using: B)
        setZeroFlag(using: B)
        return false
    }

    /// Store accumulator `D` to memory.
    ///
    /// ```
    /// M':M+1' ← R
    /// ```
    ///
    /// This instruction writes the contents of an 16-bit register into a memory location.
    ///
    /// Addressing Modes:
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
    func std(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        writeWord(addressAbsolute, data: D)
        setNegativeFlag(using: D)
        setZeroFlag(using: D)
        return false
    }

    /// Store register `X` to memory.
    ///
    /// ```
    /// M':M+1' ← R
    /// ```
    ///
    /// This instruction writes the contents of an 16-bit register into a memory location.
    ///
    /// Addressing Modes:
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
    func stx(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        writeWord(addressAbsolute, data: X)
        setNegativeFlag(using: X)
        setZeroFlag(using: X)
        return false
    }

    /// Store register `Y` to memory.
    ///
    /// ```
    /// M':M+1' ← R
    /// ```
    ///
    /// This instruction writes the contents of an 16-bit register into a memory location.
    ///
    /// Addressing Modes:
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
    func sty(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        writeWord(addressAbsolute, data: Y)
        setNegativeFlag(using: Y)
        setZeroFlag(using: Y)
        return false
    }

    /// Store register `U` to memory.
    ///
    /// ```
    /// M':M+1' ← R
    /// ```
    ///
    /// This instruction writes the contents of an 16-bit register into a memory location.
    ///
    /// Addressing Modes:
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
    func stu(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        writeWord(addressAbsolute, data: U)
        setNegativeFlag(using: U)
        setZeroFlag(using: U)
        return false
    }

    /// Store register `S` to memory.
    ///
    /// ```
    /// M':M+1' ← R
    /// ```
    ///
    /// This instruction writes the contents of an 16-bit register into a memory location.
    ///
    /// Addressing Modes:
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
    func sts(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        writeWord(addressAbsolute, data: S)
        setNegativeFlag(using: S)
        setZeroFlag(using: S)
        return false
    }
}
