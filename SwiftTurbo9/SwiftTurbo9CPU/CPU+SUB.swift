import Foundation

extension CPU {
    private func sbc(addressMode: AddressMode, register: inout UInt8) -> ShouldIncludeExtraClockCycles {
        // Overflow using `UInt8` results in an exception being thrown.
        // "Cheat" and use `UInt16` when adding instead.
        var valueToSubtract: UInt8 = 0
        
        switch addressMode
        {
        case .imm8:
            valueToSubtract = readByte(addressAbsolute) + readCC(.carry).value
        case .dir:
            valueToSubtract = readByte(addressAbsolute) + readCC(.carry).value
        case .ind:
            valueToSubtract = readByte(addressAbsolute) + readCC(.carry).value
        case .ext:
            valueToSubtract = readByte(addressAbsolute) + readCC(.carry).value
        default:
            valueToSubtract = 0
        }
        var newValue : UInt8 = 0
        
        newValue = register &- valueToSubtract

        // Set negative flag, if highest bit is set.
        setNegativeFlag(using: newValue)

        // Set zero flag.
        setZeroFlag(using: newValue)

        // Set overflow flag.
        // This flag should be set if the addition overflow in `Int8`, aka. if the result goes out of bounds of (-128 <-> +127).
        // Cast both `acc` and `valueToAdd` to `Int8`, add them and check if there's an overflow.
        let addResult = Int8(bitPattern: register).addingReportingOverflow(Int8(bitPattern: UInt8(valueToSubtract & 0xFF)))
        setCC(.overflow, addResult.overflow)

        // Set carry flag.
        setCC(.carry, newValue > 0xFF)

        register = UInt8(newValue & 0xFF)

        return true
    }

    private func subtract(addressMode: AddressMode, register: inout UInt8) -> ShouldIncludeExtraClockCycles {
        // Overflow using `UInt8` results in an exception being thrown.
        // "Cheat" and use `UInt16` when adding instead.
        var valueToSubtract: UInt16 = 0
        
        switch addressMode
        {
        case .imm8:
            valueToSubtract = readByte(addressAbsolute).asWord
        case .dir:
            valueToSubtract = readByte(addressAbsolute).asWord
        case .ind:
            valueToSubtract = readByte(addressAbsolute).asWord
        case .ext:
            valueToSubtract = readByte(addressAbsolute).asWord
        default:
            valueToSubtract = 0
        }
        var newValue : UInt16 = 0
        
        newValue = register.asWord &- valueToSubtract

        // Set negative flag, if highest bit is set.
        setNegativeFlag(using: newValue)

        // Set zero flag.
        setZeroFlag(using: newValue)

        // Set overflow flag.
        // This flag should be set if the addition overflow in `Int8`, aka. if the result goes out of bounds of (-128 <-> +127).
        // Cast both `acc` and `valueToAdd` to `Int8`, add them and check if there's an overflow.
        let addResult = Int8(bitPattern: register).addingReportingOverflow(Int8(bitPattern: UInt8(valueToSubtract & 0xFF)))
        setCC(.overflow, addResult.overflow)

        // Set carry flag.
        setCC(.carry, newValue > 0xFF)

        register = UInt8(newValue & 0xFF)

        return true
    }
    
    /// Subtract memory byte and carry from accumulator `A`.
    ///
    /// ```
    /// R' ← R + M + C
    /// ```
    ///
    /// This instruction subtracts the contents of memory location M and the borrow (in the `C` (carry) bit) from the contents of the designated 8-bit register, and places the result in that register. The `C` bit represents a borrow and is set to the inverse of the resulting binary carry.
    ///
    /// Addressing modes:
    /// - Immediate
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// - H    -    Set if a half-carry is generated; cleared otherwise.
    /// - N    -    Set if the result is negative; cleared otherwise.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Set if an overflow is generated; cleared otherwise.
    /// - C    -    Set if a borrow is generated; cleared otherwise.
    func sbca(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return sbc(addressMode: addressMode, register: &self.A)
    }

    /// Subtract memory byte and carry from accumulator `B`.
    ///
    /// ```
    /// R' ← R + M + C
    /// ```
    ///
    /// This instruction subtracts the contents of memory location M and the borrow (in the `C` (carry) bit) from the contents of the designated 8-bit register, and places the result in that register. The `C` bit represents a borrow and is set to the inverse of the resulting binary carry.
    ///
    /// Addressing modes:
    /// - Immediate
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// - H    -    Set if a half-carry is generated; cleared otherwise.
    /// - N    -    Set if the result is negative; cleared otherwise.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Set if an overflow is generated; cleared otherwise.
    /// - C    -    Set if a borrow is generated; cleared otherwise.
    func sbcb(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return sbc(addressMode: addressMode, register: &self.B)
    }

    /// Subtract memory byte and carry from accumulator `D`.
    ///
    /// ```
    /// R' ← R + M:M+1 + C
    /// ```
    ///
    /// This instruction subtracts the contents of memory location M and the borrow (in the `C` (carry) bit) from the contents of the designated 8-bit register, and places the result in that register. The `C` bit represents a borrow and is set to the inverse of the resulting binary carry.
    ///
    /// Addressing modes:
    /// - Immediate
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// - H    -    Set if a half-carry is generated; cleared otherwise.
    /// - N    -    Set if the result is negative; cleared otherwise.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Set if an overflow is generated; cleared otherwise.
    /// - C    -    Set if a borrow is generated; cleared otherwise.
    func sbcd(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        // TODO: Implement SBCD
        return false
    }

    /// Subtract from value in accumulator `A`.
    ///
    /// ```
    /// R' ← R - M
    /// ```
    ///
    /// This instruction subtracts the value in memory location M from the contents of a designated 8-bit register. The `C` (carry) bit represents a borrow and is set to the inverse of the resulting binary carry.
    ///
    /// Addressing modes:
    /// - Immediate
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// - H    -    Undefined.
    /// - N    -    Set if the result is negative; cleared otherwise.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Set if an overflow is generated; cleared otherwise.
    /// - C    -    Set if a borrow is generated; cleared otherwise.
    func suba(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return subtract(addressMode: addressMode, register: &self.A)
    }

    /// Subtract from value in accumulator `B`.
    ///
    /// ```
    /// R' ← R - M
    /// ```
    ///
    /// This instruction subtracts the value in memory location M from the contents of a designated 8-bit register. The `C` (carry) bit represents a borrow and is set to the inverse of the resulting binary carry.
    ///
    /// Addressing modes:
    /// - Immediate
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// - H    -    Undefined.
    /// - N    -    Set if the result is negative; cleared otherwise.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Set if an overflow is generated; cleared otherwise.
    /// - C    -    Set if a borrow is generated; cleared otherwise.
    func subb(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return subtract(addressMode: addressMode, register: &self.B)
    }

    /// Subtract from value in accumulator `D`.
    ///
    /// ```
    /// R' ← R - M:M+1
    /// ```
    ///
    /// This instruction subtracts the value in memory location M from the contents of a designated 8-bit register. The `C` (carry) bit represents a borrow and is set to the inverse of the resulting binary carry.
    ///
    /// Addressing modes:
    /// - Immediate
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// - H    -    Undefined.
    /// - N    -    Set if the result is negative; cleared otherwise.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Set if an overflow is generated; cleared otherwise.
    /// - C    -    Set if a borrow is generated; cleared otherwise.
    func subd(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        // Overflow using `UInt8` results in an exception being thrown.
        // "Cheat" and use `UInt16` when adding instead.
        var valueToSubtract: UInt16 = 0
        
        switch addressMode
        {
        case .imm8:
            valueToSubtract = readWord(addressAbsolute)
            PC = PC &+ 1
        case .dir:
            valueToSubtract = readWord(addressAbsolute)
        case .ind:
            valueToSubtract = readWord(addressAbsolute)
        case .ext:
            valueToSubtract = readWord(addressAbsolute)
        default:
            valueToSubtract = 0
        }
        var newValue : UInt16 = 0
        
        newValue = UInt16(truncatingIfNeeded: Int(D) &- Int(valueToSubtract))

        // Set negative flag, if highest bit is set.
        setNegativeFlag(using: newValue >> 8)

        // Set zero flag.
        setZeroFlag(using: newValue)

        // Set overflow flag.
        // This flag should be set if the addition overflow in `Int16`, aka. if the result goes out of bounds of (-32768 <-> +32767).
        // Cast both `D` and `valueToAdd` to `Int16`, add them and check if there's an overflow.
        let addResult = Int16(bitPattern: D).addingReportingOverflow(Int16(bitPattern: valueToSubtract))
        setCC(.overflow, addResult.overflow)

        // Set carry flag.
        setCC(.carry, newValue > 0xFFFF)

        D = UInt16(newValue & 0xFFFF)

        return true
    }
}
