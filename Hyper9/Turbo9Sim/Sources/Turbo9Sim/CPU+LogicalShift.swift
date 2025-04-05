import Foundation

extension Turbo9CPU {
    private func lshift(addressMode: AddressMode, register: inout UInt8, left: Bool) -> ShouldIncludeExtraClockCycles {
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
            setCC(.carry, (value & 0x80) == 0x80)
            value = value << 1
            setCC(.overflow, xor == 1)
        } else {
            setCC(.carry, (value & 0x01) == 0x01)
            value = value >> 1
        }

        setNegativeFlag(using: value)
        setZeroFlag(using: value)

        let byte = value & 0xFF

        if addressMode == .inh {
            register = byte
        } else {
            writeByte(addressAbsolute, data: byte)
        }

        return false
    }

    /// Logical shift left of accumulator `A`.
    ///
    /// This instruction shifts all bits of the accumulator or memory location one place to the left. Bit zero is loaded with a zero. Bit seven of the accumulator or memory location is shifted into the `C `(carry) bit.
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
    func lsla(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return lshift(addressMode: addressMode, register: &A, left: true)
    }
    
    /// Logical shift left of accumulator `B`.
    ///
    /// This instruction shifts all bits of the accumulator or memory location one place to the left. Bit zero is loaded with a zero. Bit seven of the accumulator or memory location is shifted into the `C `(carry) bit.
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
    func lslb(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return lshift(addressMode: addressMode, register: &B, left: true)
    }

    /// Logical shift left of memory byte.
    ///
    /// This instruction shifts all bits of the accumulator or memory location one place to the left. Bit zero is loaded with a zero. Bit seven of the accumulator or memory location is shifted into the `C `(carry) bit.
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
    func lsl(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return lshift(addressMode: addressMode, register: &B, left: true)
    }

    /// Logical shift right of accumulator `A`.
    ///
    /// This instruction performs a logical shift right on the operand. Shifts a zero into bit seven and bit zero into the `C` (carry) bit.
    ///
    /// Addressing modes:
    /// - Inherent
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// - H    -    Undefined.
    /// - N    -    Always cleared.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Not affected.
    /// - C    -    Loaded with bit zero of the original operand.
    func lsra(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return lshift(addressMode: addressMode, register: &A, left: false)
    }
    
    /// Logical shift right of accumulator `B`.
    ///
    /// This instruction performs a logical shift right on the operand. Shifts a zero into bit seven and bit zero into the `C` (carry) bit.
    ///
    /// Addressing modes:
    /// - Inherent
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// - H    -    Undefined.
    /// - N    -    Always cleared.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Not affected.
    /// - C    -    Loaded with bit zero of the original operand.
    func lsrb(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return lshift(addressMode: addressMode, register: &B, left: false)
    }

    /// Logical shift right of memory byte.
    ///
    /// This instruction performs a logical shift right on the operand. Shifts a zero into bit seven and bit zero into the `C` (carry) bit.
    ///
    /// Addressing modes:
    /// - Inherent
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// - H    -    Undefined.
    /// - N    -    Always cleared.
    /// - Z    -    Set if the result is zero; cleared otherwise.
    /// - V    -    Not affected.
    /// - C    -    Loaded with bit zero of the original operand.
    func lsr(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return lshift(addressMode: addressMode, register: &B, left: false)
    }
}
