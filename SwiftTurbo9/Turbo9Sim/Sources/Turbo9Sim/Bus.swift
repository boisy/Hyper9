import Foundation

public struct BusHandler {
    public var address : UInt16
    public var handler: (_ value: UInt8) -> Void
    
    public init(address: UInt16, handler: @escaping (_: UInt8) -> Void) {
        self.address = address
        self.handler = handler
    }
}

/// The system bus that defines the interface to the CPU.
///
/// Memory mapped I/O begins at $FF00 and is mapped accordingly:
///
/// $FF00 (Read): last character written to terminal
///      (Write): character goes to terminal
///
/// $FF01 (Read): timer status register
///     - bit 0: 1=interrupt on timer fired; 0 = interrupt on timer didn't fire
///      (Write):
///     - bit 0: 1 = clear interrupt; 0 = no effect
///
/// $FF02 (Read): timer control register
///     - bit 0: 1=interrupt on timer fire is set; 0 = interrupt on timer fire is clear
///      (Write):
///     - bit 0: 1=set interrupt on timer fire; 0 = don't interrupt on timer fire
public class Bus {
    var busHandlers : [BusHandler] = []
    weak var cpu: CPU?
    var clockInterrupt : Timer? = nil
    var ram: [UInt8]
    var originalRam: [UInt8]
    var timerTriggersIRQ: Bool = false
    private var timer: Timer?
    
    init(ram: [UInt8] = Array(repeating: UInt8(0x00), count: Int(UInt16.max) + 1)) {
        self.ram = ram
        self.originalRam = ram
//        timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
//            self?.invokeTimer()
//        }
    }
    
    public func addHandler(handler : BusHandler) {
        self.busHandlers.append(handler)
    }
    
    public func invokeTimer() {
        // Set the bit indicating the timer has fired
        ram[0xFF01] = ram[0xFF01] | 0x01
        
        // If the timer control register's "interrupt on timer fire" is set, assert the IRQ
        if ram[0xFF02] & 0x01 == 0x01 {
            cpu?.assertIRQ()
        }
    }
    
    func refresh() {
    }

    func reset() {
        self.ram = self.originalRam
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
        switch address {
        case 0xFF00:
            ram[Int(address)] = data
        case 0xFF01:
            // Writing 1 to bit 0 deasserts IRQ
            if (data & 0x01) == 0x01 {
                let v = read(0xFF01) & 0xFE
                ram[0xFF01] = v
                cpu?.deassertIRQ()
            } else {
                ram[Int(address)] = data
            }
        case 0xFF02:
            // Writing 1 to bit 0 allows the timer to trigger the interrupt, otherwise writing 0 inhibits that behavior.
            if (data & 0x01) == 0x01 {
                timerTriggersIRQ = true
            } else {
                timerTriggersIRQ = false
            }
            ram[Int(address)] = data
        default:
            break
        }
        
        for handler in busHandlers {
            if address == handler.address {
                handler.handler(data)
            }
        }
    }

    func mappedIOReadHandler(_ address: UInt16) -> UInt8 {
        switch address {
        case 0xFF00:
            return ram[Int(address)]
        case 0xFF01:
            return ram[Int(address)]
        default:
            return ram[Int(address)]
        }
    }
}
