import Foundation

extension Turbo9CPU {
    enum CCFlag: UInt8, CaseIterable {
        case entire       = 0b10000000  // Entire.
        case firq         = 0b01000000  // FIRQ mask.
        case halfcarry    = 0b00100000  // Half Carry.
        case irq          = 0b00010000  // IRQ mask.
        case negative     = 0b00001000  // Negative.
        case zero         = 0b00000100  // Zero.
        case overflow     = 0b00000010  // Overflow.
        case carry        = 0b00000001  // Carry.

        var letter: String {
            switch self {
            case .entire:
                "E"
            case .firq:
                "F"
            case .halfcarry:
                "H"
            case .irq:
                "I"
            case .negative:
                "N"
            case .zero:
                "Z"
            case .overflow:
                "V"
            case .carry:
                "C"
            }
        }
    }
}
