import Foundation

extension String {
    public var asUInt16FromHex: UInt16 {
        let trimmed = self.trimmingCharacters(in: .whitespacesAndNewlines)

        // Check for 0x or 0X prefix
        if trimmed.lowercased().hasPrefix("0x") {
            return UInt16(trimmed.dropFirst(2), radix: 16)!
        }

        // Check if it's a valid hex string (0–9, A–F/a–f)
        if trimmed.range(of: #"^[0-9a-fA-F]+$"#, options: .regularExpression) != nil {
            return UInt16(trimmed, radix: 16)!
        }

        return 0 // Not a valid number
    }
}
