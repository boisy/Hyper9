import Foundation

extension Turbo9CPU {
    private func logical_or(addressMode: AddressMode, register: inout UInt8) -> ShouldIncludeExtraClockCycles {
        let value = readByte(addressAbsolute)

        register = register | value

        setZeroFlag(using: register)
        setNegativeFlag(using: register)
        setCC(.overflow, false)

        return true
    }

    /// Logically OR memory byte with accumulator `A`.
    ///
    /// ```
    /// R' ← R ∨ M
    /// ```
    ///
    /// This instruction performs an inclusive OR operation between the contents of the accumulator and the contents of memory location M and the result is stored in tje accumulator.
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
    func ora(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return logical_or(addressMode: addressMode, register: &A)
    }
    
    /// Logically OR memory byte with accumulator `B`.
    ///
    /// ```
    /// R' ← R ∨ M
    /// ```
    ///
    /// This instruction performs an inclusive OR operation between the contents of the accumulator and the contents of memory location M and the result is stored in tje accumulator.
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
    func orb(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return logical_or(addressMode: addressMode, register: &B)
    }
    
    /// Logically OR memory byte with condtion code register `CC`.
    ///
    /// ```
    /// R' ← R ∨ MI
    /// ```
    ///
    /// This instruction performs an inclusive OR operation between the contents of the condition code registers and the immediate value, and the result is placed in the condition code register. This instruction may be used to set interrupt masks (disable interrupts) or any other bit(s).
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
    func orcc(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        let value = readByte(addressAbsolute)

        CC = CC | value

        return true
    }
}
