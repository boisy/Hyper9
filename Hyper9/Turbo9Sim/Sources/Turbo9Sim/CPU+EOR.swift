import Foundation

extension Turbo9CPU {
    private func eor(addressMode: AddressMode, register: inout UInt8) -> ShouldIncludeExtraClockCycles {
        var value: UInt8

        value = readByte(addressAbsolute)
        
        register = value ^ register

        setNegativeFlag(using: register)
        setZeroFlag(using: register)
        setCC(.overflow, false)

        return false
    }

    /// Exclusively-OR memory byte with accumulator `A`.
    ///
    /// ```
    /// r’ ← r ⊕ (M)
    /// ```
    ///
    /// The contents of memory location `M` is exclusive ORed into an 8-bit register.
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
    func eora(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return eor(addressMode: addressMode, register: &A)
    }
    
    /// Exclusively-OR memory byte with accumulator `B`.
    ///
    /// ```
    /// r’ ← r ⊕ (M)
    /// ```
    ///
    /// The contents of memory location `M` is exclusive ORed into an 8-bit register.
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
    func eorb(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return eor(addressMode: addressMode, register: &B)
    }
}
