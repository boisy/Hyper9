import Foundation

extension Turbo9CPU {
    /// Clear condition code bits and wait for interrupt.
    ///
    /// ```
    /// CC’ ←CC AND IMM
    /// CC’ ←CC OR 8016 (E flag)
    /// ```
    ///
    /// This instruction ANDs an immediate byte with the condition code register which may clear the interrupt mask bits `I` and `F`, stacks the entire machine state on the hardware stack and then looks for an interrupt. When a non-masked interrupt occurs, no further machine state information need be saved before vectoring to the interrupt handling routine. This instruction does not place the buses in a high-impedance state. A FIRQ (fast interrupt request) may enter its interrupt handler with its entire machine state saved. The `RTI` (return from interrupt) instruction will automatically return the entire machine state after testing the `E` (entire) bit of the recovered condition code register.
    ///
    /// Addressing modes:
    /// - Immediate
    ///
    /// Condition codes: Affected according to the operation.
    func cwai(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        let result = andcc(addressMode: addressMode)
        pushToS(word: PC)
        pushToS(word: U)
        pushToS(word: Y)
        pushToS(word: X)
        pushToS(byte: DP)
        pushToS(byte: B)
        pushToS(byte: A)
        setCC(.entire, true)
        pushToS(byte:CC)
        PC = PC &- 2
        syncToInterrupt = true
        return result
    }

    /// Synchronize with interrupt.
    ///
    /// ```
    /// CC’ ←CC AND IMM
    /// CC’ ←CC OR 8016 (E flag)
    /// ```
    ///
    /// When this instruction is excuted, the processor enters a synchronizing state, stops processing instructions, and waits for an interrupt. When an interrupt occurs, the synchronizing state is cleared and processing continues. If the interrupt is enabled, and it lasts three cycles or more, the processor will perform the interrupt routine. If the interrupt is masked or is shorter than three cycles, the processor simply continues to the next instruction. While in the synchronizing state, the address and data buses are in the high-impedance state.
    ///
    /// Addressing modes:
    /// - Immediate
    ///
    /// Condition codes: Not affected.
    func sync(addressMode: AddressMode) -> ShouldIncludeExtraClockCycles {
        syncToInterrupt = true
        return true
    }
}
