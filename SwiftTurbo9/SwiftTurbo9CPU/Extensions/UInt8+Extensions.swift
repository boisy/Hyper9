import Foundation

extension UInt8 {
    var asWord: UInt16 {
        UInt16(self)
    }
    
    var asSigned: Int8 {
        Int8(bitPattern: self)
    }
}
