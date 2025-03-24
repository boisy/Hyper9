import Foundation

extension Int8 {
    var asWord: Int16 {
        Int16(self)
    }

    var asHex: String {
        String(format: "$%02hhX", self)
    }
    
    var asHexNoDollar: String {
        String(format: "%04hX", self)
    }
}
