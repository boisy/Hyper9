//
//  Disassembler+Dump.swift
//  Turbo9Sim
//
//  Created by Boisy Pitre on 1/31/25.
//

import Foundation

// MARK: - Enumerations

extension Bus {
    enum DumpFormat {
        case standard
        case asmHex
        case asmBin
        case cFormat
    }
    
    // MARK: - Helper Functions
    
    /// Converts a byte to its binary string representation.
    func binary(_ byte: UInt8) -> String {
        var binaryString = ""
        for i in (0..<8).reversed() {
            binaryString += (byte & (1 << i)) != 0 ? "1" : "0"
        }
        return binaryString
    }
    
    /// Prints the header for the dump based on the format.
    func dumpHeader(format: DumpFormat, displayLabel: Bool = true, displayASCII: Bool = true, displayHeader: Bool = true) -> String {
        var output = ""
        guard format == .standard && displayHeader else { return output}
        
        output += "\n\n"
        if displayLabel {
            output += "Addr  "
        }
        output += " 0 1  2 3  4 5  6 7  8 9  A B  C D  E F"
        if displayASCII {
            output += " 0 2 4 6 8 A C E"
        }
        output += "\n"
        
        if displayLabel {
            output += "----  "
        }
        output += "---- ---- ---- ---- ---- ---- ---- ----"
        if displayASCII {
            output += " ----------------"
        }
        
        return output
    }
    
    /// Dumps a single line of the buffer based on the format.
    func dumpLine(buffer: [UInt8], count: Int, format: DumpFormat, displayASCII: Bool = true, dumpChunk: Int = 16) -> String {
        var output = ""
        var carry = false
        var actualCount = count
        
        // Handle odd byte count
        if count % 2 != 0 {
            actualCount -= 1
            carry = true
        }
        
        // Process bytes in pairs
        for i in stride(from: 0, to: actualCount, by: 2) {
            switch format {
            case .standard:
                output += String(format: "%02x%02x ", buffer[i], buffer[i + 1])
            case .asmHex:
                if i == actualCount - 2 && !carry {
                    output += String(format: "$%02X,$%02X", buffer[i], buffer[i + 1])
                } else {
                    output += String(format: "$%02X,$%02X,", buffer[i], buffer[i + 1])
                }
            case .asmBin:
                if i == actualCount - 2 && !carry {
                    output += "%%\(binary(buffer[i])),%%\(binary(buffer[i + 1]))"
                } else {
                    output += "%%\(binary(buffer[i])),%%\(binary(buffer[i + 1])),"
                }
            case .cFormat:
                output += String(format: "0x%02X,0x%02X,", buffer[i], buffer[i + 1])
            }
        }
        
        // Handle the last byte if count is odd
        if carry {
            switch format {
            case .standard:
                output += String(format: "%02x", buffer[actualCount])
            case .asmHex:
                output += String(format: "$%02X", buffer[actualCount])
            case .asmBin:
                output += "%%\(binary(buffer[actualCount]))"
            case .cFormat:
                output += String(format: "0x%02X,", buffer[actualCount])
            }
            actualCount += 1
        }
        
        // Handle ASCII display
        if displayASCII {
            let remaining = dumpChunk - actualCount
            if format == .asmHex {
                output += "   "
            }
            
            var spaceString = ""
            if remaining % 2 != 0 {
                switch format {
                case .asmHex, .cFormat:
                    spaceString += "     "
                default:
                    spaceString += "   "
                }
            }
            let half = remaining / 2
            for _ in 0..<half {
                switch format {
                case .asmHex:
                    spaceString += "        "
                case .cFormat:
                    spaceString += "          "
                default:
                    spaceString += "     "
                }
            }
            output += spaceString
            
            if format == .cFormat {
                output += "  // "
            }
            
            // Append ASCII characters
            for i in 0..<actualCount {
                let byte = buffer[i]
                if byte >= 32 && byte < 127 {
                    let scalar = UnicodeScalar(byte)
                    output += String(Character(scalar))
                } else {
                    output += "."
                }
            }
        }
        
        return output
    }
    
    func ramDump(address: UInt32, numBytes: Int, format: DumpFormat = .standard) -> String {
        return dump(buffer: memory, offset: address, numBytes: numBytes, format: format)
    }
    
    // MARK: - Main Dump Function
    
    /// Dumps the buffer in the specified format.
    ///
    /// - Parameters:
    ///   - buffer: The byte buffer to dump.
    ///   - offset: The starting offset.
    ///   - numBytes: The number of bytes to dump.
    ///   - format: The format to use for dumping.
    func dump(buffer: [UInt8], offset: UInt32, numBytes: Int, format: DumpFormat = .standard, displayLabel: Bool = true, dumpChunk: Int = 16) -> String {
        var output = ""
        var currentOffset = offset
        var j: UInt32 = 0
        var i = 0
        
        while i < numBytes {
            if (j % 256) == 0 {
                output += dumpHeader(format: format)
                j = 0
            }
            
            // Print the header based on the format
            switch format {
            case .standard:
                if displayLabel {
                    output += String(format: "\n%04X  ", currentOffset)
                } else {
                    output += "\n"
                }
            case .asmHex, .asmBin:
                if displayLabel {
                    output += String(format: "\nL%04X    fcb   ", currentOffset)
                } else {
                    output += "\n         fcb   "
                }
            case .cFormat:
                if displayLabel {
                    output += String(format: "\n   /* offset = %08X */ ", currentOffset)
                } else {
                    output += "\n   "
                }
            }
            
            // Determine the chunk size
            let remaining = numBytes - i
            let chunkSize = remaining > dumpChunk ? dumpChunk : remaining
            let chunk = Array(memory[i + Int(offset)..<(i + Int(offset) + chunkSize)])
            
            // Dump the line
            output += dumpLine(buffer: chunk, count: chunkSize, format: format)
            
            // Update counters
            currentOffset += UInt32(dumpChunk)
            j += UInt32(dumpChunk)
            i += dumpChunk
        }
        
        return output
    }
}
