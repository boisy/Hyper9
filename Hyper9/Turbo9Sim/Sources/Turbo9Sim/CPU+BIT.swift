import Foundation

extension Turbo9CPU {
    /// Test bits in accumulator `A`.
    ///
    /// This instruction performs the logical AND operation between the contents of accumulator `A` modifies the condition codes accordingly. The contents of accumulator `A` is affected.
    ///
    /// ```
    /// TEMP ← R ∧ M
    /// ```
    ///
    /// Addressing modes:
    /// - Immediate
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// - H    -    Not affected.
    /// - N    -    Set if the result is negative; cleared otherwise.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Always cleared.
    /// - C    -    Not affected.
    func bita(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return bit(addressMode: addressMode, register: &A)
    }

    /// Test bits in accumulator `B`.
    ///
    /// This instruction performs the logical AND operation between the contents of accumulator `B` modifies the condition codes accordingly. The contents of accumulator `B` is affected.
    ///
    /// ```
    /// TEMP ← R ∧ M
    /// ```
    ///
    /// Addressing modes:
    /// - Immediate
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// - H    -    Not affected.
    /// - N    -    Set if the result is negative; cleared otherwise.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Always cleared.
    /// - C    -    Not affected.
    func bitb(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return bit(addressMode: addressMode, register: &B)
    }

    private func bit(addressMode: AddressMode, register: inout UInt8) -> ShouldIncludeExtraClockCycles {
        let memory = readByte(addressAbsolute)

        setNegativeFlag(using: memory)
        setZeroFlag(using: register & memory)
        setCC(.overflow, false)

        return false
    }
}
