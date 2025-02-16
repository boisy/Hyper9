import Foundation

extension Turbo9CPU {
    private func rotate(addressMode: AddressMode, register: inout UInt8, left: Bool) -> ShouldIncludeExtraClockCycles {
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
            value = value << 1
            if readCC(.carry) == true {
                value |= 0x01
            }
            setCC(.overflow, xor == 1)
            setCC(.carry, bit7 == 1)
        } else {
            let setCarry = (value & 0x01) == 0x01
            value = value >> 1
            if readCC(.carry) == true {
                value |= 0x80
            }
            setCC(.negative, (value & 0x80) == 0x80)
            setCC(.carry, setCarry)
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

    /// Rotate accumulator `A` left through carry.
    ///
    /// This instruction rotates all bits of the operand one place left through the C (carry) bit. This is a 9-bit rotation.
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
    func rola(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return rotate(addressMode: addressMode, register: &A, left: true)
    }
    
    /// Rotate accumulator `B` left through carry.
    ///
    /// This instruction rotates all bits of the operand one place left through the C (carry) bit. This is a 9-bit rotation.
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
    func rolb(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return rotate(addressMode: addressMode, register: &B, left: true)
    }

    /// Rotate memory byte left through carry.
    ///
    /// This instruction rotates all bits of the operand one place left through the C (carry) bit. This is a 9-bit rotation.
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
    func rol(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return rotate(addressMode: addressMode, register: &B, left: true)
    }

    /// Rotate accumulator `A` right through carry.
    ///
    /// This instruction rotates all bits of the operand one place right through the C (carry) bit. This is a 9-bit rotation.
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
    /// - C    -    Loaded with bit zero of the previous operand.
    func rora(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return rotate(addressMode: addressMode, register: &A, left: false)
    }
    
    /// Rotate accumulator `B` right through carry.
    ///
    /// This instruction rotates all bits of the operand one place right through the C (carry) bit. This is a 9-bit rotation.
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
    /// - C    -    Loaded with bit zero of the previous operand.
    func rorb(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return rotate(addressMode: addressMode, register: &B, left: false)
    }

    /// Rotate memory byte right through carry.
    ///
    /// This instruction rotates all bits of the operand one place right through the C (carry) bit. This is a 9-bit rotation.
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
    /// - C    -    Loaded with bit zero of the previous operand.
    func ror(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return rotate(addressMode: addressMode, register: &B, left: false)
    }
}
