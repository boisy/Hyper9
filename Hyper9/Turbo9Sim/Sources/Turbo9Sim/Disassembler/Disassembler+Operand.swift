import Foundation

extension Disassembler {
    enum Operand: CustomStringConvertible {
        case inherent
        case immediate8(UInt8)
        case immediate16(UInt16)
        case extended(UInt16)
        case direct(UInt8)
        case indexed(UInt8)
        case relative8(UInt8)
        case relative16(UInt16)
        case none

        var description: String {
            switch self {
            case .inherent:
                return "Inherent"
            case .immediate8(let value):
                return "Immediate8(\(value))"
            case .immediate16(let value):
                return "Immediate16(\(value))"
            case .extended(let value):
                return "Extended(\(value))"
            case .direct(let value):
                return "Direct(\(value))"
            case .indexed(let value):
                return "Indexed(\(value))"
            case .relative8(let value):
                return "Relative8(\(value))"
            case .relative16(let value):
                return "Relative16(\(value))"
            case .none:
                return "None"
            }
        }
        
        var hexDescription: String {
            switch self {
            case .inherent:
                return ""
            case .immediate8(let value):
                return String(format: "%02X", value)
            case .immediate16(let value):
                return String(format: "%04X", value)
            case .extended(let value):
                return String(format: "%04X", value)
            case .direct(let value):
                return String(format: "%02X", value)
            case .indexed(let value):
                return String(format: "%02X", value)
            case .relative8(let value):
                return String(format: "%02X", value)
            case .relative16(let value):
                return String(format: "%04X", value)
            case .none:
                return ""
            }
        }
    }
}
