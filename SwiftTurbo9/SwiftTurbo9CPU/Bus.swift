import Foundation

/// The system bus that defines the interface to the CPU.
class Bus {
    @Published var outputTerminalCharacter: UInt8 = 0x00
    var ram: [UInt8]
    
    init(ram: [UInt8] = Array(repeating: UInt8(0x00), count: Int(UInt16.max) + 1)) {
        self.ram = ram
    }
    
    func read(_ address: UInt16) -> UInt8 {
        guard ram.indices.contains(Int(address)) else { return 0 }
        if address >= 0xFF00 && address < 0xFFF0 {
            // Call mapped I/O handler
           return  mappedIOReadHandler(address)
        } else {
            return ram[Int(address)]
        }
    }
    
    func write(_ address: UInt16, data: UInt8) {
        guard ram.indices.contains(Int(address)) else { return }
        if address >= 0xFF00 && address < 0xFFF0 {
            // Call mapped I/O handler
            mappedIOWriteHandler(address, data: data)
        } else {
            ram[Int(address)] = data
        }
    }
    
    func mappedIOWriteHandler(_ address: UInt16, data: UInt8) {
        outputTerminalCharacter = data
    }

    func mappedIOReadHandler(_ address: UInt16) -> UInt8 {
        return outputTerminalCharacter
    }

}
