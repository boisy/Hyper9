import Foundation

extension CPU {
    private func ashift(addressMode: AddressMode, register: inout UInt8, left: Bool) -> ShouldIncludeExtraClockCycles {
        var value: UInt8

        if addressMode == .inh {
            value = register
        } else {
            value = readByte(addressAbsolute)
        }

        if left == true {
            let bit6 = (value & 0x40) >> 6
            let bit7 = (value & 0x80) >> 7
            let xor = bit6 ^ bit7
            setCC(.carry, value & 0x80 == 0x80)
            value = value << 1
            setCC(.overflow, xor == 1)
        } else {
            setCC(.carry, value & 0x01 == 0x01)
            value = value >> 1
        }

        setNegativeFlag(using: value)
        setZeroFlag(using: value)

        let byte = UInt8(value & 0x00FF)

        if addressMode == .inh {
            register = byte
        } else {
            writeByte(addressAbsolute, data: byte)
        }

        return false
    }

    /// Arithmetic shift left of accumulator `A`.
    ///
    /// This instruction shifts all bits of the operand one place to the left. Bit zero is loaded with a zero. Bit seven is shifted into the C (carry) bit.
    ///
    /// Addressing modes:
    /// - Inherent
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// - H    -    Undefined.
    /// - N    -    Set if the result is negative; cleared otherwise.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Loaded with the result of the exclusive OR of bits six and seven of the original operand.
    /// - C    -    Loaded with bit seven of the original operand.
    func asla(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return ashift(addressMode: addressMode, register: &A, left: true)
    }
    
    /// Arithmetic shift left of accumulator `B`.
    ///
    /// This instruction shifts all bits of the operand one place to the left. Bit zero is loaded with a zero. Bit seven is shifted into the C (carry) bit.
    ///
    /// Addressing modes:
    /// - Inherent
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// - H    -    Undefined.
    /// - N    -    Set if the result is negative; cleared otherwise.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Loaded with the result of the exclusive OR of bits six and seven of the original operand.
    /// - C    -    Loaded with bit seven of the original operand.
    func aslb(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return ashift(addressMode: addressMode, register: &B, left: true)
    }

    /// Arithmetic shift left of memory byte.
    ///
    /// This instruction shifts all bits of the operand one place to the left. Bit zero is loaded with a zero. Bit seven is shifted into the C (carry) bit.
    ///
    /// Addressing modes:
    /// - Inherent
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// - H    -    Undefined.
    /// - N    -    Set if the result is negative; cleared otherwise.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Loaded with the result of the exclusive OR of bits six and seven of the original operand.
    /// - C    -    Loaded with bit seven of the original operand.
    func asl(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return ashift(addressMode: addressMode, register: &B, left: true)
    }

    /// Arithmetic shift right of accumulator `A`.
    ///
    /// This instruction shifts all bits of the operand one place to the right. Bit seven is held constant. Bit zero is shifted into the C (carry) bit.
    ///
    /// Addressing modes:
    /// - Inherent
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// - H    -    Undefined.
    /// - N    -    Set if the result is negative; cleared otherwise.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Not affected.
    /// - C    -    Loaded with bit zero of the original operand.
    func asra(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return ashift(addressMode: addressMode, register: &A, left: false)
    }
    
    /// Arithmetic shift right of accumulator `B`.
    ///
    /// This instruction shifts all bits of the operand one place to the right. Bit seven is held constant. Bit zero is shifted into the C (carry) bit.
    ///
    /// Addressing modes:
    /// - Inherent
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// - H    -    Undefined.
    /// - N    -    Set if the result is negative; cleared otherwise.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Not affected.
    /// - C    -    Loaded with bit zero of the original operand.
    func asrb(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return ashift(addressMode: addressMode, register: &B, left: false)
    }

    /// Arithmetic shift right of memory byte.
    ///
    /// This instruction shifts all bits of the operand one place to the right. Bit seven is held constant. Bit zero is shifted into the C (carry) bit.
    ///
    /// Addressing modes:
    /// - Inherent
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// - H    -    Undefined.
    /// - N    -    Set if the result is negative; cleared otherwise.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Not affected.
    /// - C    -    Loaded with bit zero of the original operand.
    func asr(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return ashift(addressMode: addressMode, register: &B, left: false)
    }
}
