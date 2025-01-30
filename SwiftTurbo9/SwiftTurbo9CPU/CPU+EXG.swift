import Foundation

extension CPU {
    /// Retrieve the value of a 16-bit register.
    private func getRegister16(_ reg: Register) throws -> UInt16 {
        switch reg {
        case .D:
            return D
        case .X:
            return X
        case .Y:
            return Y
        case .U:
            return U
        case .SP:
            return S
        default:
            throw CPUError.invalidRegister
        }
    }
    
    /// Set the value of a 16-bit register.
    private func setRegister16(_ reg: Register, value: UInt16) throws {
        switch reg {
        case .D:
            D = value
        case .X:
            X = value
        case .Y:
            Y = value
        case .U:
            U = value
        case .SP:
            S = value
        default:
            throw CPUError.invalidRegister
        }
    }
    
    /// Retrieve the value of an 8-bit register.
    private func getRegister8(_ reg: Register) throws -> UInt8 {
        switch reg {
        case .A:
            return A
        case .B:
            return B
        default:
            throw CPUError.invalidRegister
        }
    }
    
    /// Set the value of an 8-bit register.
    private func setRegister8(_ reg: Register, value: UInt8) throws {
        switch reg {
        case .A:
            A = value
        case .B:
            B = value
        default:
            throw CPUError.invalidRegister
        }
    }

    /// Exchange registers.
    ///
    /// ```
    /// r0 ↔ r1
    /// ```
    ///
    /// This instruction exchanges data between two designated registers. Bits 3-0 of the postbyte define one register, while bits 7-4 define the other, as follows:
    ///
    /// ```
    /// 0000 =    A:B        1000 =    A
    /// 0001 =    X          1001 =    B
    /// 0010 =    Y          1010 =    CCR
    /// 0011 =    US         1011 =    DPR
    /// 0100 =    SP         1100 =    Undefined
    /// 0101 =    PC         1101 =    Undefined
    /// 0110 =    Undefined  1110 =    Undefined
    /// 0111 =    Undefined  1111 =    Undefined
    /// ```
    ///
    /// Only like size registers may be exchanged. (8-bit with 8-bit or 16-bit with 16-bit.)
    ///
    /// Addressing modes:
    /// - Immediate
    ///
    /// Condition codes: Not affected (unless one of the registers is the condition code register).
    func exg(addressMode: AddressMode) throws -> ShouldIncludeExtraClockCycles {
        var postByte: UInt8
        
        postByte = readByte(addressAbsolute)
        
        let r1 = Int((postByte & 0xF0) >> 4)
        let r2 = Int(postByte & 0x0F)
        
        let reg1 = Register.registerMapping(r1)
        let reg2 = Register.registerMapping(r2)
        
        // Ensure both registers are of the same type.
        guard reg1.type == reg2.type else {
            throw CPUError.mismatchedRegisterTypes
        }

        switch reg1.type {
        case .eightBit:
            // Swap 8-bit registers.
            let val1 = try getRegister8(reg1)
            let val2 = try getRegister8(reg2)
            try setRegister8(reg1, value: val2)
            try setRegister8(reg2, value: val1)
        case .sixteenBit:
            // Swap 16-bit registers.
            let val1 = try getRegister16(reg1)
            let val2 = try getRegister16(reg2)
            try setRegister16(reg1, value: val2)
            try setRegister16(reg2, value: val1)
        }

        return false
    }
}
