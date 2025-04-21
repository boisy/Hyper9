import Foundation

extension Int8 {
    var asWord: Int16 {
        Int16(self)
    }

    var asSignedString: String {
        String(self)
    }

    var asUnsignedString: String {
        String(UInt8(bitPattern: self))
    }

    var asHex: String {
        String(format: "$%02hhX", self)
    }
    
    var asHexNoDollar: String {
        String(format: "%04hX", self)
    }
}
