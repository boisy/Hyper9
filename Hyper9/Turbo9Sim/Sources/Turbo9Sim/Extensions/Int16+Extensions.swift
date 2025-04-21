import Foundation

extension Int16 {
    var highByte: Int8 {
        Int8(self >> 8)
    }
    
    var asSignedString: String {
        String(Int16(self))
    }

    var asUnsignedString: String {
        String(UInt16(self))
    }

    var asHex: String {
        String(format: "$%04hX", self)
    }
    
    var asHexNoDollar: String {
        String(format: "%04hX", self)
    }

    var lowByte: Int8 {
        Int8(self & 0xFF)
    }

    func isSamePage(as other: Int16) -> Bool {
        highByte == other.highByte
    }

    static func createWord(highByte: Int8, lowByte: Int8) -> Int16 {
        (highByte.asWord << 8) | lowByte.asWord
    }
}
