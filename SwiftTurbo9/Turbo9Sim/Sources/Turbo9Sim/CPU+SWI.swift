import Foundation

extension Turbo9CPU {
    /// Software interrupt.
    ///
    /// All of the processor registers are pushed onto the hardware stack (with the exception of the hardware stack pointer itself), and control is transferred through the software interrupt vector. Both the normal and fast interrupts are masked (disabled).
    ///
    /// Addressing Modes:
    /// - Inherent
    ///
    /// Condition codes: Not affected.
    func swi(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        pushToS(word: PC)
        pushToS(word: U)
        pushToS(word: Y)
        pushToS(word: X)
        pushToS(byte: DP)
        pushToS(byte: B)
        pushToS(byte: A)
        pushToS(byte: CC)
        setCC(.firq, true)
        setCC(.irq, true)
        PC = readWord(0xFFFA)
        return true
    }
    
    /// Software interrupt 2.
    ///
    /// All of the processor registers are pushed onto the hardware stack (with the exception of the hardware stack pointer itself), and control is transferred through the software interrupt 2 vector. This interrupt is available to the end user and must not be used in packaged software. This interrupt does not mask (disable) the normal and fast interrupts.
    ///
    /// Addressing Modes:
    /// - Inherent
    ///
    /// Condition codes: Not affected.
    func swi2(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        setCC(.entire, true)
        pushToS(word: PC)
        pushToS(word: U)
        pushToS(word: Y)
        pushToS(word: X)
        pushToS(byte: DP)
        pushToS(byte: B)
        pushToS(byte: A)
        pushToS(byte: CC)
        PC = readWord(0xFFF4)
        return true
    }
    
    /// Software interrupt 3.
    ///
    /// All of the processor registers are pushed onto the hardware stack (with the exception of the hardware stack pointer itself), and control is transferred through the software interrupt 3 vector. This interrupt does not mask (disable) the normal and fast interrupts.
    ///
    /// Addressing Modes:
    /// - Inherent
    ///
    /// Condition codes: Not affected.
    func swi3(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        setCC(.entire, true)
        pushToS(word: PC)
        pushToS(word: U)
        pushToS(word: Y)
        pushToS(word: X)
        pushToS(byte: DP)
        pushToS(byte: B)
        pushToS(byte: A)
        pushToS(byte: CC)
        PC = readWord(0xFFF2)
        return true
    }
}
