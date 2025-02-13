import Foundation

extension Int16 {
    var highByte: Int8 {
        Int8(self >> 8)
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
