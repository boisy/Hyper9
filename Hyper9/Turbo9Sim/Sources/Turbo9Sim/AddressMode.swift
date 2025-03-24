import Foundation

public enum AddressMode {
    case inh    // Inherent.
    case imm8   // Immediate 8-bit.
    case imm16  // Immediate 16-bit.
    case ext    // Extended.
    case dir    // Direct.
    case ind    // Indirect.
    case rel8   // Relative 8-bit.
    case rel16  // Relative 16-bit.
}
