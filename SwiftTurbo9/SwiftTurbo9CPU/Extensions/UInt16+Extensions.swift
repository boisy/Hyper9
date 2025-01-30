import Foundation

extension UInt16 {
    var highByte: UInt8 {
        UInt8(self >> 8)
    }
    
    var lowByte: UInt8 {
        UInt8(self & 0xFF)
    }

    var asSigned: Int16 {
        Int16(bitPattern: self)
    }

    func isSamePage(as other: UInt16) -> Bool {
        highByte == other.highByte
    }

    static func createWord(highByte: UInt8, lowByte: UInt8) -> UInt16 {
        (highByte.asWord << 8) | lowByte.asWord
    }
    
}
