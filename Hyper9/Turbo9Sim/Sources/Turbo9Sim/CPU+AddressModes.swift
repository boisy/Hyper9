import Foundation

extension Turbo9CPU {
    func setupAddressing(using addressMode: AddressMode) {
        switch addressMode {
        case .inh: inh()
        case .imm8: imm8()
        case .imm16: imm16()
        case .dir: dir()
        case .ext: ext()
        case .ind: ind()
        case .rel8: rel8()
        case .rel16: rel16()
        }
    }
}

private extension Turbo9CPU {
    /// Inherent addressing mode.
    private func inh() {
    }

    /// Immediate 8-bit.
    ///
    /// The addressing mode will read the next byte as the data.
    /// This means that the program counter will already be pointing to this address.
    private func imm8() {
        addressAbsolute = PC
        PC = PC &+ 1
    }

    /// Immediate 16-bit.
    ///
    /// The addressing mode will read the next word as the data.
    /// This means that the program counter will already be pointing to this address.
    private func imm16() {
        addressAbsolute = PC
        PC = PC &+ 2
    }

    /// Direct.
    ///
    /// Point a direct page address.
    private func dir() {
        addressAbsolute = (UInt16(readByte(PC)) &+ (UInt16(DP) * 256))
        PC = PC &+ 1
    }

    /// Relative 8-bit.
    ///
    /// Relative addressing allows for a navigating to an address within -128 to +127 of the program counter.
    private func rel8() {
        var addressRelative = readByte(PC).asWord
        PC = PC &+ 1

        // If the relative offset is negative, we need to flip the highest bits so a "subtraction" will occur.
        if addressRelative & 0x80 == 0x80 {
            addressRelative |= 0xFF00
        }

        // Add the relative offset to the current program counter.
        addressAbsolute = PC &+ addressRelative
    }

    /// Relative 16-bit.
    ///
    /// Relative addressing allows for a navigating to an address within -32768 to +32767 of the program counter.
    private func rel16() {
        var addressRelative = readWord(PC)
        PC = PC &+ 2

        // If the relative offset is negative, we need to flip the highest bits so a "subtraction" will occur.
        if addressRelative & 0x8000 == 0x8000 {
            let result = Int16(bitPattern: addressRelative)
            addressRelative = UInt16(truncatingIfNeeded: result)
        }

        // Add the relative offset to the current program counter.
        addressAbsolute = PC &+ addressRelative
    }

    /// Absolute.
    ///
    /// Will read the two next bytes and form them into an address.
    private func ext() {
        addressAbsolute = readWord(PC)
        PC = PC &+ 2
    }

    /// Indirect, aka. pointer.
    ///
    /// The next byte forms a postbyte which dictates what byte or bytes follow.
    private func ind() {
        let postByte = readByte(PC)
        PC = PC &+ 1
        
        // Determine mode type.
        var registerAddAmount : Int16 = 0
        let registerNo = (postByte & 0x60) >> 5
        var registerValue : UInt16 = 0
        var effectiveAddress : UInt16 = 0
        var least5 = Int8(postByte & 0x1F)
        switch registerNo {
        case 0:
            registerValue = X
        case 1:
            registerValue = Y
        case 2:
            registerValue = U
        default:
            registerValue = S
        }
        if postByte & 0x80 == 0 {
            // 5-bit offset - if bit 4 is 1 then result is negative
            if least5 & 0x10 == 0x10 {
                let comp = ~least5 & 0x0F
                least5 = -(comp + 1)
            }
            let result = Int(registerValue) &+ Int(least5)
            effectiveAddress = UInt16(truncatingIfNeeded: result)
        } else {
            switch least5 {
            case 0: // direct auto increment by 1
                effectiveAddress = UInt16(truncatingIfNeeded:Int(registerValue) + Int(registerAddAmount))
                registerAddAmount = 1
            case 1: // direct auto increment by 2
                effectiveAddress = UInt16(truncatingIfNeeded:Int(registerValue) + Int(registerAddAmount))
                registerAddAmount = 2
            case 2: // direct auto decrement by 1
                registerAddAmount = -1
                effectiveAddress = UInt16(truncatingIfNeeded:Int(registerValue) + Int(registerAddAmount))
            case 3: // direct auto decrement by 2
                registerAddAmount = -2
                effectiveAddress = UInt16(truncatingIfNeeded:Int(registerValue) + Int(registerAddAmount))
            case 4: // direct constant offset from register (2s complement) no offset
                effectiveAddress = registerValue
            case 5: // direct B accumulator offset from register (2s complement)
                let signed = Int8(bitPattern: B)
                let result = Int(registerValue) &+ Int(signed)
                effectiveAddress = UInt16(truncatingIfNeeded: result)
            case 6: // direct A accumulator offset from register (2s complement)
                let signed = Int8(bitPattern: A)
                let result = Int(registerValue) &+ Int(signed)
                effectiveAddress = UInt16(truncatingIfNeeded: result)
            case 8: // direct constant offset from register 8-bit
                let nextValue = Int8(bitPattern: readByte(PC))
                PC = PC &+ 1
                let result = Int(registerValue) &+ Int(nextValue)
                effectiveAddress = UInt16(truncatingIfNeeded: result)
            case 9: // direct constant offset from register 16-bit
                let nextValue = Int16(bitPattern: readWord(PC))
                PC = PC &+ 2
                let result = Int(registerValue) &+ Int(nextValue)
                effectiveAddress = UInt16(truncatingIfNeeded: result)
            case 11: // direct D accumulator offset from register (2s complement)
                let d = UInt16(A) * 256 + UInt16(B)
                let signedResult = Int16(bitPattern: d)
                let signedAsUInt = UInt16(bitPattern: signedResult)
                let result = registerValue &+ signedAsUInt
                effectiveAddress = result
            case 12: // direct constant offset from program counter 8-bit
                let nextValue = Int8(bitPattern: readByte(PC))
                PC = PC &+ 1
                let result = Int(PC) &+ Int(nextValue)
                effectiveAddress = UInt16(truncatingIfNeeded: result)
            case 13: // direct constant offset from program counter 16-bit
                let nextValue = Int16(bitPattern: readWord(PC))
                PC = PC &+ 2
                let result = Int(PC) &+ Int(nextValue)
                effectiveAddress = UInt16(truncatingIfNeeded: result)
            case 20: // indirect constant offset from register (2s complement - no offset) no offset
                let result = Int(registerValue)
                effectiveAddress = readWord(UInt16(truncatingIfNeeded: result))
            case 24: // indirect constant offset from register (2s complement - no offset) 8 bit offset
                let nextValue = Int8(bitPattern: readByte(PC))
                PC = PC &+ 1
                let result = Int(registerValue) &+ Int(nextValue)
                effectiveAddress = readWord(UInt16(truncatingIfNeeded: result))
            case 25: // indirect constant offset from register (2s complement - no offset) 16 bit offset
                let nextValue = Int16(bitPattern: readWord(PC))
                PC = PC &+ 2
                let result = Int(registerValue) &+ Int(nextValue)
                effectiveAddress = readWord(UInt16(truncatingIfNeeded: result))
            case 21: // indirect B accumulator offset from register (2s complement offset)
                let result = Int(registerValue) &+ Int(B)
                effectiveAddress = readWord(readWord(UInt16(truncatingIfNeeded: result)))
            case 22: // indirect A accumulator offset from register (2s complement offset)
                let result = Int(registerValue) &+ Int(A)
                effectiveAddress = readWord(readWord(UInt16(truncatingIfNeeded: result)))
            case 27: // indirect D accumulator offset from register (2s complement offset)
                let result = Int(registerValue) &+ Int(D)
                effectiveAddress = readWord(readWord(UInt16(truncatingIfNeeded: result)))
            case 17: // indirect auto increment by 2 from register
                effectiveAddress = readWord(registerValue)
            case 19: // indirect auto decrement by 2 from register
                effectiveAddress = readWord(registerValue)
            case 28: // indirect constant offset from program counter 8-bit offset
                let nextValue = Int8(bitPattern: readByte(PC))
                PC = PC &+ 1
                let result = Int(PC) &+ Int(nextValue)
                effectiveAddress = readWord(UInt16(result))
            case 29: // indirect constant offset from program counter 16-bit offset
                let nextValue = Int16(bitPattern: readWord(PC))
                PC = PC &+ 2
                let result = Int(PC) + Int(nextValue)
                let uResult = UInt16(result & 0xFFFF)
                effectiveAddress = readWord(uResult)
            case 31: // extended indirect 16-bit address
                let nextValue = Int16(bitPattern: readWord(PC))
                PC = PC &+ 2
                let result = Int(nextValue)
                effectiveAddress = readWord(UInt16(result & 0xFFFF))
            default:
                effectiveAddress = 0
            }
            
            switch registerNo {
            case 0:
                X = X &+ UInt16(bitPattern: registerAddAmount)
            case 1:
                Y = Y &+ UInt16(bitPattern: registerAddAmount)
            case 2:
                U = U &+ UInt16(bitPattern: registerAddAmount)
            default:
                S = S &+ UInt16(bitPattern: registerAddAmount)
            }
        }
        
        addressAbsolute = effectiveAddress
    }
}
