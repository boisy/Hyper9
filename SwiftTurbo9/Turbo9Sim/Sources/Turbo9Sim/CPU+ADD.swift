import Foundation

extension CPU {
    private func add(addressMode: AddressMode, register: inout UInt8, useCarry: Bool) -> ShouldIncludeExtraClockCycles {
        // Overflow using `UInt8` results in an exception being thrown.
        // "Cheat" and use `UInt16` when adding instead.
        var valueToAdd: UInt8 = 0
        
        switch addressMode
        {
        case .imm8:
            valueToAdd = readByte(addressAbsolute)
        case .dir:
            valueToAdd = readByte(addressAbsolute)
        case .ind:
            valueToAdd = readByte(addressAbsolute)
        case .ext:
            valueToAdd = readByte(addressAbsolute)
        default:
            valueToAdd = 0
        }
        var newValue : UInt8 = 0
        
        newValue = register &+ valueToAdd
        if useCarry == true && readCC(.carry) == true {
            newValue = newValue &+ 1
        }
        
        // Set half carry if bit 3 was 1 and carried to bit 4
        setCC(.halfcarry, (newValue & 0x18) == 0x10 && (register & 0x18) == 0x08)

        // Set negative flag, if highest bit is set.
        setNegativeFlag(using: newValue)

        // Set zero flag.
        setZeroFlag(using: newValue)

        // Set overflow flag.
        // This flag should be set if the addition overflow in `Int8`, aka. if the result goes out of bounds of (-128 <-> +127).
        // Cast both `acc` and `valueToAdd` to `Int8`, add them and check if there's an overflow.
        let addResult = Int8(bitPattern: register).addingReportingOverflow(Int8(bitPattern: UInt8(valueToAdd & 0xFF)))
        setCC(.overflow, addResult.overflow)

        // Set carry flag.
        setCC(.carry, UInt(valueToAdd) + UInt(register) > 0xFF)

        register = UInt8(newValue & 0xFF)

        return true
    }

    /// Add accumulator `B` to index register `X`.
    ///
    /// This instruction adds the 8-bit unsigned value in accumulator `B` into index register `X`.
    ///
    /// ```
    /// IX' ← IX + ACCB
    /// ```
    ///
    /// Addressing modes:
    /// - Inherent
    ///
    /// Condition codes: Not affected.
    func abx(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        X = X &+ B.asWord

        return false
    }

    /// Add memory byte plus carry to accumulator `A`.
    ///
    /// This instruction adds the contents of the C (carry) bit and the memory byte into an 8-bit accumulator.
    ///
    /// ```
    /// R' ← R + M + C
    /// ```
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
    /// - C    -    Set if a carry is generated; cleared otherwise.
    func adca(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return add(addressMode: addressMode, register: &self.A, useCarry: true)
    }

    /// Add memory byte plus carry to accumulator `B`.
    ///
    /// This instruction adds the contents of the C (carry) bit and the memory byte into an 8-bit accumulator.
    ///
    /// ```
    /// R' ← R + M + C
    /// ```
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
    /// - C    -    Set if a carry is generated; cleared otherwise.
    func adcb(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return add(addressMode: addressMode, register: &self.B, useCarry: true)
    }

    /// Add memory byte to accumulator `A`.
    ///
    /// This instruction adds the memory byte into an 8-bit accumulator.
    ///
    /// ```
    /// R' ← R + M
    /// ```
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
    /// - C    -    Set if a carry is generated; cleared otherwise.
    func adda(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return add(addressMode: addressMode, register: &self.A, useCarry: true)
    }

    /// Add memory byte to accumulator `B`.
    ///
    /// This instruction adds the memory byte into an 8-bit accumulator.
    ///
    /// ```
    /// R' ← R + M
    /// ```
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
    /// - C    -    Set if a carry is generated; cleared otherwise.
    func addb(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return add(addressMode: addressMode, register: &self.B, useCarry: true)
    }

    /// Add memory byte to accumulator `D`.
    ///
    /// This instruction adds the 16-bit memory value into the 16-bit accumulator.
    ///
    /// ```
    /// R' ← R + M:M+1
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
    /// - V    -    Set if an overflow is generated; cleared otherwise.
    /// - C    -    Set if a carry is generated; cleared otherwise.
    func addd(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        // Overflow using `UInt8` results in an exception being thrown.
        // "Cheat" and use `UInt16` when adding instead.
        var valueToAdd: UInt16 = 0
        
        switch addressMode
        {
        case .imm8:
            valueToAdd = readWord(addressAbsolute)
        case .imm16:
            valueToAdd = readWord(addressAbsolute)
        case .dir:
            valueToAdd = readWord(addressAbsolute)
        case .ind:
            valueToAdd = readWord(addressAbsolute)
        case .ext:
            valueToAdd = readWord(addressAbsolute)
        default:
            valueToAdd = 0
        }
        var newValue : UInt16 = 0
        
        newValue = UInt16(truncatingIfNeeded: Int(D) + Int(valueToAdd))

        // Set negative flag, if highest bit is set.
        setNegativeFlag(using: newValue)

        // Set zero flag.
        setZeroFlag(using: newValue)

        // Set overflow flag.
        // This flag should be set if the addition overflow in `Int16`, aka. if the result goes out of bounds of (-32768 <-> +32767).
        // Cast both `D` and `valueToAdd` to `Int16`, add them and check if there's an overflow.
        let addResult = Int16(bitPattern: D).addingReportingOverflow(Int16(bitPattern: valueToAdd))
        setCC(.overflow, addResult.overflow)

        // Set carry flag.
        setCC(.carry, newValue > 0xFFFF)

        D = UInt16(newValue & 0xFFFF)

        return true
    }
}
