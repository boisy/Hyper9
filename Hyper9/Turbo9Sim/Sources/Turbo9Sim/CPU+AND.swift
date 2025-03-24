import Foundation

extension Turbo9CPU {
    private func and(addressMode: AddressMode, register: inout UInt8) -> ShouldIncludeExtraClockCycles {
        let value = readByte(addressAbsolute)

        register = register & value

        setNegativeFlag(using: register)
        setZeroFlag(using: register)
        setCC(.overflow, false)

        return true
    }

    /// Logically AND memory byte with accumulator `A`.
    ///
    /// This instruction performs the logical AND operation between the contents of an accumulator and the contents of memory location M and the result is stored in the accumulator.
    ///
    /// ```
    /// R' ← R ∧ M
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
    func anda(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return and(addressMode: addressMode, register: &A)
    }
    
    /// Logically AND memory byte with accumulator `B`.
    ///
    /// This instruction performs the logical AND operation between the contents of an accumulator and the contents of memory location M and the result is stored in the accumulator.
    ///
    /// ```
    /// R' ← R ∧ M
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
    func andb(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return and(addressMode: addressMode, register: &B)
    }

    /// Logically AND immediate value with the `CC` register.
    ///
    /// This instruction performs a logical AND between the condition code register and the immediate byte specified in the instruction and places the result in the condition code register.
    ///
    /// ```
    /// R' ← R ∧ MI
    /// ```
    ///
    /// Addressing modes:
    /// - Immediate
    ///
    /// Condition codes: Affected according to the operation.
    func andcc(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        let value = readByte(addressAbsolute)

        CC = CC & value

        return true
    }
}
