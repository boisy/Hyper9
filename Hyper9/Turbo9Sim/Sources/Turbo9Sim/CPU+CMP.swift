import Foundation

extension Turbo9CPU {
    private func compareMemoryAgainst(_ value: UInt8) {
        let memory = readByte(addressAbsolute)


        // Set flags based on difference between value and memory.
        let diff = value &- memory
        setZeroFlag(using: diff)
        setNegativeFlag(using: diff)
        let addResult = Int8(bitPattern: value).addingReportingOverflow(Int8(bitPattern: UInt8(memory & 0xFF)))
        setCC(.overflow, addResult.overflow)
        // If register is less than memory, then set carry flag to true.
        setCC(.carry, value < memory)
    }

    private func compareMemoryAgainst(_ value: UInt16) {
        let memory = readWord(addressAbsolute)

        // Set flags based on difference between value and memory.
        let diff = value &- memory
        setZeroFlag(using: diff)
        setNegativeFlag(using: diff)
        let addResult = Int16(bitPattern: value).addingReportingOverflow(Int16(bitPattern: UInt16(memory & 0xFFFF)))
        setCC(.overflow, addResult.overflow)
        // If register is less than memory, then set carry flag to true.
        setCC(.carry, value < memory)
    }
    
    /// Compare memory byte from accumulator `A`.
    ///
    /// Compares the contents of memory location to the contents of the accmulator and sets the appropriate condition codes. The register isn't modified. The carry flag represents a borrow and is set to the inverse of the resulting binary carry.
    ///
    /// Addressing modes:
    /// - Immediate
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// H    -    Undefined.
    /// N    -    Set if the result is negative; cleared otherwise.
    /// Z    -    Set if the result is zero; cleared otherwise.
    /// V    -    Set if an overflow is generated; cleared otherwise.
    /// C    -    Set if a borrow is generated; cleared otherwise.
    func cmpa(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        compareMemoryAgainst(A)
        return true
    }

    /// Compare memory byte from accumulator `B`.
    ///
    /// Compares the contents of memory location to the contents of the accmulator and sets the appropriate condition codes. The register isn't modified. The carry flag represents a borrow and is set to the inverse of the resulting binary carry.
    ///
    /// Addressing modes:
    /// - Immediate
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// H    -    Undefined.
    /// N    -    Set if the result is negative; cleared otherwise.
    /// Z    -    Set if the result is zero; cleared otherwise.
    /// V    -    Set if an overflow is generated; cleared otherwise.
    /// C    -    Set if a borrow is generated; cleared otherwise.
    func cmpb(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        compareMemoryAgainst(B)
        return true
    }

    /// Compare memory byte from accumulator `D`.
    ///
    /// Compares the contents of memory location to the contents of the accmulator and sets the appropriate condition codes. The register isn't modified. The carry flag represents a borrow and is set to the inverse of the resulting binary carry.
    ///
    /// Addressing modes:
    /// - Immediate
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// H    -    Undefined.
    /// N    -    Set if the result is negative; cleared otherwise.
    /// Z    -    Set if the result is zero; cleared otherwise.
    /// V    -    Set if an overflow is generated; cleared otherwise.
    /// C    -    Set if a borrow is generated; cleared otherwise.
    func cmpd(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        compareMemoryAgainst(D)
        return true
    }

    /// Compare memory byte from register `X`.
    ///
    /// Compares the contents of memory location to the contents of the accmulator and sets the appropriate condition codes. The register isn't modified. The carry flag represents a borrow and is set to the inverse of the resulting binary carry.
    ///
    /// Addressing modes:
    /// - Immediate
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// H    -    Undefined.
    /// N    -    Set if the result is negative; cleared otherwise.
    /// Z    -    Set if the result is zero; cleared otherwise.
    /// V    -    Set if an overflow is generated; cleared otherwise.
    /// C    -    Set if a borrow is generated; cleared otherwise.
    func cmpx(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        compareMemoryAgainst(X)
        return false
    }

    /// Compare memory byte from register `Y`.
    ///
    /// Compares the contents of memory location to the contents of the accmulator and sets the appropriate condition codes. The register isn't modified. The carry flag represents a borrow and is set to the inverse of the resulting binary carry.
    ///
    /// Addressing modes:
    /// - Immediate
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// H    -    Undefined.
    /// N    -    Set if the result is negative; cleared otherwise.
    /// Z    -    Set if the result is zero; cleared otherwise.
    /// V    -    Set if an overflow is generated; cleared otherwise.
    /// C    -    Set if a borrow is generated; cleared otherwise.
    func cmpy(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        compareMemoryAgainst(Y)
        return false
    }

    /// Compare memory byte from register `U`.
    ///
    /// Compares the contents of memory location to the contents of the accmulator and sets the appropriate condition codes. The register isn't modified. The carry flag represents a borrow and is set to the inverse of the resulting binary carry.
    ///
    /// Addressing modes:
    /// - Immediate
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// H    -    Undefined.
    /// N    -    Set if the result is negative; cleared otherwise.
    /// Z    -    Set if the result is zero; cleared otherwise.
    /// V    -    Set if an overflow is generated; cleared otherwise.
    /// C    -    Set if a borrow is generated; cleared otherwise.
    func cmpu(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        compareMemoryAgainst(U)
        return false
    }

    /// Compare memory byte from register `S`.
    ///
    /// Compares the contents of memory location to the contents of the accmulator and sets the appropriate condition codes. The register isn't modified. The carry flag represents a borrow and is set to the inverse of the resulting binary carry.
    ///
    /// Addressing modes:
    /// - Immediate
    /// - Extended
    /// - Direct
    /// - Indexed
    ///
    /// Condition codes:
    /// H    -    Undefined.
    /// N    -    Set if the result is negative; cleared otherwise.
    /// Z    -    Set if the result is zero; cleared otherwise.
    /// V    -    Set if an overflow is generated; cleared otherwise.
    /// C    -    Set if a borrow is generated; cleared otherwise.
    func cmps(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        compareMemoryAgainst(S)
        return false
    }
}
