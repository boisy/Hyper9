import Foundation

extension Turbo9CPU {
    /// Branch if carry clear.
    ///
    /// Tests the state of the C (carry) bit and causes a branch if it is clear.
    /// 
    /// ```
    /// IF CC.C = 0 then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func bcc(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if !readCC(.carry) {
            PC = addressAbsolute
        }
        return false
    }

    /// Long branch if carry clear.
    ///
    /// Tests the state of the C (carry) bit and causes a branch if it is clear.
    ///
    /// ```
    /// IF CC.C = 0 then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func lbcc(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if !readCC(.carry) {
            PC = addressAbsolute
        }
        return false
    }

    /// Branch if carry set.
    ///
    /// Tests the state of the C (carry) bit and causes a branch if it is set.
    ///
    /// ```
    /// IF CC.C ≠ 0 then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func bcs(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if readCC(.carry) {
            PC = addressAbsolute
        }
        return false
    }

    /// Long branch if carry set.
    ///
    /// Tests the state of the C (carry) bit and causes a branch if it is set.
    ///
    /// ```
    /// IF CC.C ≠ 0 then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func lbcs(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if readCC(.carry) {
            PC = addressAbsolute
        }
        return false
    }

    /// Branch if equal to zero.
    ///
    /// Tests the state of the Z (zero) bit and causes a branch if it is set. When used after a subtract or compare operation, this instruction will branch if the compared values, signed or unsigned, were exactly the same.
    ///
    /// ```
    /// IF CC.Z ≠ 0 then PC’ ←  PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func beq(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if readCC(.zero) == true {
            PC = addressAbsolute
        }
        return false
    }

    /// Long branch if equal to zero.
    ///
    /// Tests the state of the Z (zero) bit and causes a branch if it is set. When used after a subtract or compare operation, this instruction will branch if the compared values, signed or unsigned, were exactly the same.
    ///
    /// ```
    /// IF CC.Z ≠ 0 then PC’ ←  PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func lbeq(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if readCC(.zero) == true {
            PC = addressAbsolute
        }
        return false
    }

    /// Branch if greater than or equal to zero.
    ///
    ///  Causes a branch if the N (negative) bit and the V (overflow) bit are either both set or both clear. That is, branch if the sign of a valid twos complement result is, or would be, positive. When used after a subtract or compare operation on twos complement values, this instruction will branch if the register was greater than or equal to the memory operand.
    ///
    /// ```
    /// IF CC.N = CC.V then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func bge(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if readCC(.negative) == readCC(.overflow) {
            PC = addressAbsolute
        }
        return false
    }

    /// Long branch if greater than or equal to zero.
    ///
    ///  Causes a branch if the N (negative) bit and the V (overflow) bit are either both set or both clear. That is, branch if the sign of a valid twos complement result is, or would be, positive. When used after a subtract or compare operation on twos complement values, this instruction will branch if the register was greater than or equal to the memory operand.
    ///
    /// ```
    /// IF CC.N = CC.V then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func lbge(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if readCC(.negative) == readCC(.overflow) {
            PC = addressAbsolute
        }
        return false
    }

    /// Branch if greater than zero.
    ///
    /// Causes a branch if the N (negative) bit and V (overflow) bit are either both set or both clear and the Z (zero) bit is clear. In other words, branch if the sign of a valid twos complement result is, or would be, positive and not zero. When used after a subtract or compare operation on twos complement values, this instruction will branch if the register was greater than the memory operand.
    ///
    /// ```
    /// IF (CC.N = CC.V) AND (CC.Z = 0) then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func bgt(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if readCC(.negative) == readCC(.overflow) && readCC(.zero) == false {
            PC = addressAbsolute
        }
        return false
    }

    /// Long branch if greater than zero.
    ///
    /// Causes a branch if the N (negative) bit and V (overflow) bit are either both set or both clear and the Z (zero) bit is clear. In other words, branch if the sign of a valid twos complement result is, or would be, positive and not zero. When used after a subtract or compare operation on twos complement values, this instruction will branch if the register was greater than the memory operand.
    ///
    /// ```
    /// IF (CC.N = CC.V) AND (CC.Z = 0) then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func lbgt(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if readCC(.negative) == readCC(.overflow) && readCC(.zero) == false {
            PC = addressAbsolute
        }
        return false
    }

    /// Branch if higher.
    ///
    /// Causes a branch if the previous operation caused neither a carry nor a zero result. When used after a subtract or compare operation on unsigned binary values, this instruction will branch if the register was higher than the memory operand.
    ///
    /// ```
    /// IF (CC.Z = 0) AND (CC.C = 0) then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func bhi(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if readCC(.zero) == false && readCC(.carry) == false {
            PC = addressAbsolute
        }
        return false
    }

    /// Long branch if higher.
    ///
    /// Causes a branch if the previous operation caused neither a carry nor a zero result. When used after a subtract or compare operation on unsigned binary values, this instruction will branch if the register was higher than the memory operand.
    ///
    /// ```
    /// IF (CC.Z = 0) AND (CC.C = 0) then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func lbhi(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if readCC(.zero) == false && readCC(.carry) == false {
            PC = addressAbsolute
        }
        return false
    }

    /// Branch if less than or equal to zero.
    ///
    /// Causes a branch if the exclusive OR of the N (negative) and V (overflow) bits is 1 or if the Z (zero) bit is set. That is, branch if the sign of a valid twos complement result is, or would be, negative. When used after a subtract or compare operation on twos complement values, this instruction will branch if the register was less than or equal to the memory operand.
    ///
    /// ```
    /// IF (CC.N ≠ CC.V) OR (CC.Z = 1) then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func ble(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if readCC(.negative) != readCC(.overflow) || readCC(.zero) == true {
            PC = addressAbsolute
        }
        return false
    }

    /// Long branch if less than or equal to zero.
    ///
    /// Causes a branch if the exclusive OR of the N (negative) and V (overflow) bits is 1 or if the Z (zero) bit is set. That is, branch if the sign of a valid twos complement result is, or would be, negative. When used after a subtract or compare operation on twos complement values, this instruction will branch if the register was less than or equal to the memory operand.
    ///
    /// ```
    /// IF (CC.N ≠ CC.V) OR (CC.Z = 1) then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func lble(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if readCC(.negative) != readCC(.overflow) || readCC(.zero) == true {
            PC = addressAbsolute
        }
        return false
    }

    /// Branch if lower or same
    ///
    /// Causes a branch if the previous operation caused either a carry or a zero result. When used after a subtract or compare operation on unsigned binary values, this instruction will branch if the register was lower than or the same as the memory operand.
    ///
    /// ```
    /// IF (CC.Z ≠ 0) OR (CC.C ≠ 0) then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func bls(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if readCC(.zero) != false || readCC(.carry) != false {
            PC = addressAbsolute
        }
        return false
    }

    /// Long branch if lower or same.
    ///
    /// Causes a branch if the previous operation caused either a carry or a zero result. When used after a subtract or compare operation on unsigned binary values, this instruction will branch if the register was lower than or the same as the memory operand.
    ///
    /// ```
    /// IF (CC.Z ≠ 0) OR (CC.C ≠ 0) then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func lbls(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if readCC(.zero) != false || readCC(.carry) != false {
            PC = addressAbsolute
        }
        return false
    }

    /// Branch if less than zero.
    ///
    /// Causes a branch if either, but not both, of the N (negative) or V (overflow) bits is set. That is, branch if the sign of a valid twos complement result is, or would be, negative. When used after a subtract or compare operation on twos complement binary values, this instruction will branch if the register was less than the memory operand.
    ///
    /// ```
    /// IF CC.N ≠ CC.V then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func blt(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if readCC(.negative) != readCC(.overflow) {
            PC = addressAbsolute
        }
        return false
    }

    /// Long branch if less than zero.
    ///
    /// Causes a branch if either, but not both, of the N (negative) or V (overflow) bits is set. That is, branch if the sign of a valid twos complement result is, or would be, negative. When used after a subtract or compare operation on twos complement binary values, this instruction will branch if the register was less than the memory operand.
    ///
    /// ```
    /// IF CC.N ≠ CC.V then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func lblt(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if readCC(.negative) != readCC(.overflow) {
            PC = addressAbsolute
        }
        return false
    }

    /// Branch if minus.
    ///
    /// Tests the state of the N (negative) bit and causes a branch if set. That is, branch if the sign of the twos complement result is negative.
    ///
    /// ```
    /// IF CC.N ≠ 0 then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func bmi(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if readCC(.negative) {
            PC = addressAbsolute
        }
        return false
    }

    /// Long branch if minus.
    ///
    /// Tests the state of the N (negative) bit and causes a branch if set. That is, branch if the sign of the twos complement result is negative.
    ///
    /// ```
    /// IF CC.N ≠ 0 then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func lbmi(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if readCC(.negative) {
            PC = addressAbsolute
        }
        return false
    }

    /// Branch if not equal to zero.
    ///
    /// Tests the state of the Z (zero) bit and causes a branch if it is clear. When used after a subtract or compare operation on any binary values, this instruction will branch if the register is, or would be, not equal to the memory operand.
    ///
    /// ```
    /// IF CC.Z = 0 then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func bne(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if readCC(.zero) == false {
            PC = addressAbsolute
        }
        return false
    }

    /// Long branch if not equal to zero.
    ///
    /// Tests the state of the Z (zero) bit and causes a branch if it is clear. When used after a subtract or compare operation on any binary values, this instruction will branch if the register is, or would be, not equal to the memory operand.
    ///
    /// ```
    /// IF CC.Z = 0 then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func lbne(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if readCC(.zero) == false {
            PC = addressAbsolute
        }
        return false
    }

    /// Branch if plus.
    ///
    /// Tests the state of the N (negative) bit and causes a branch if it is clear. That is, branch if the sign of the twos complement result is positive.
    ///
    /// ```
    /// IF CC.N = 0 then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func bpl(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if !readCC(.negative) {
            PC = addressAbsolute
        }
        return false
    }

    /// Long branch if plus.
    ///
    /// Tests the state of the N (negative) bit and causes a branch if it is clear. That is, branch if the sign of the twos complement result is positive.
    ///
    /// ```
    /// IF CC.N = 0 then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func lbpl(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if !readCC(.negative) {
            PC = addressAbsolute
        }
        return false
    }

    /// Branch always.
    ///
    /// Causes an unconditional branch.
    ///
    /// ```
    /// PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func bra(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        PC = addressAbsolute
        return false
    }

    /// Long branch always.
    ///
    /// Causes an unconditional branch.
    ///
    /// ```
    /// PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func lbra(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        PC = addressAbsolute
        return false
    }

    /// Branch never.
    ///
    /// Does not cause a branch. This instruction is essentially a no operation, but has a bit pattern logically related to branch always.
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func brn(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return false
    }

    /// Long branch never.
    ///
    /// Does not cause a branch. This instruction is essentially a no operation, but has a bit pattern logically related to branch always.
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func lbrn(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        return false
    }

    /// Branch to subroutine.
    ///
    /// The program counter is pushed onto the stack. The program counter is then loaded with the sum of the program counter and the offset.
    ///
    /// ```
    /// S’ ← S - 2
    /// (S:S+1)← PC
    /// PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func bsr(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        pushToS(word: PC)
        PC = addressAbsolute
        return false
    }
    
    /// Long branch to subroutine.
    ///
    /// The program counter is pushed onto the stack. The program counter is then loaded with the sum of the program counter and the offset.
    ///
    /// ```
    /// S’ ← S - 2
    /// (S:S+1)← PC
    /// PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func lbsr(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        pushToS(word: PC)
        PC = addressAbsolute
        return false
    }

    /// Branch if overflow clear.
    ///
    /// Tests the state of the V (overflow) bit and causes a branch if it is clear. That is, branch if the twos complement result was valid. When used after an operation on twos complement binary values, this instruction will branch if there was no overflow.
    ///
    /// ```
    /// IF CC.V = 0 then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func bvc(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if !readCC(.overflow) {
            PC = addressAbsolute
        }
        return false
    }

    /// Long branch if overflow clear.
    ///
    /// Tests the state of the V (overflow) bit and causes a branch if it is clear. That is, branch if the twos complement result was valid. When used after an operation on twos complement binary values, this instruction will branch if there was no overflow.
    ///
    /// ```
    /// IF CC.V = 0 then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func lbvc(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if !readCC(.overflow) {
            PC = addressAbsolute
        }
        return false
    }

    /// Branch if overflow set.
    ///
    /// Tests the state of the V (overflow) bit and causes a branch if it is set. That is, branch if the twos complement result was invalid. When used after an operation on twos complement binary values, this instruction will branch if there was an overflow.
    ///
    /// ```
    /// IF CC.V ≠ 0 then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func bvs(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if readCC(.overflow) {
            PC = addressAbsolute
        }
        return false
    }

    /// Long branch if overflow set.
    ///
    /// Tests the state of the V (overflow) bit and causes a branch if it is set. That is, branch if the twos complement result was invalid. When used after an operation on twos complement binary values, this instruction will branch if there was an overflow.
    ///
    /// ```
    /// IF CC.V ≠ 0 then PC’ ← PC + IMM
    /// ```
    ///
    /// Addressing modes:
    /// - Relative
    ///
    /// Condition codes: Not affected.
    func lbvs(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        if readCC(.overflow) {
            PC = addressAbsolute
        }
        return false
    }
}
