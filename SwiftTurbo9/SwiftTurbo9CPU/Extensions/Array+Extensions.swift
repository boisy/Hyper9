import Foundation

extension Array where Element == UInt8 {
    func isWithinBounds(_ address: UInt16) -> Bool {
        indices.contains(Int(address))
    }

    static func createRam(withProgram program: [UInt8], loadAddress : UInt16 = 0x0000) -> [UInt8] {
        Array(repeating: 0x00, count: Int(loadAddress)) +
        program + Array(repeating: 0x00, count: 0xFFFF + 1 - program.count - Int(loadAddress))
    }
}
