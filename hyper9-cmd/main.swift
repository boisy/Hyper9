//
//  main.swift
//  hyper9-cmd
//
//  Created by Boisy Pitre on 3/9/25.
//

import Foundation
import Turbo9Sim

public func invokeTimer() {
    // Set the bit indicating the timer has fired
    let value = turbo9.bus.read(0xFF02)
    turbo9.bus.write(0xFF02, data: value | 0x01)
    
    // If the timer control register's "interrupt on timer fire" is set, assert the IRQ
    if (turbo9.bus.read(0xFF03) & 0x01) == 0x01 {
        turbo9.assertIRQ()
    }
}


var timerRunning = false
let turbo9 = Disassembler()
try turbo9.load(url: URL(fileURLWithPath: "/Users/boisy/Projects/turbos/ports/turbo9sim/turbos_full.img"))

let outputHandler = BusWriteHandler(address: 0xFF00, callback: { value in
    print(String(format: "%c", value), terminator: "")
})

let timerStatusHandler = BusWriteHandler(address: 0xFF02, callback: { value in
    // Writing 1 to bit 0 deasserts IRQ
    if (value & 0x01) == 0x01 {
        let _ = turbo9.bus.read(0xFF02, readThroughIO: true) & 0xFE
        turbo9.deassertIRQ()
    }
})

let timerControlHandler = BusWriteHandler(address: 0xFF03, callback: { value in
    if (value & 0x01) == 0x01 {
        timerRunning = true
    } else {
        timerRunning = false
    }
})

turbo9.bus.addWriteHandler(handler: outputHandler)
turbo9.bus.addWriteHandler(handler: timerStatusHandler)
turbo9.bus.addWriteHandler(handler: timerControlHandler)

try turbo9.reset()

repeat {
    try turbo9.step()
    if turbo9.clockCycles % 3000 == 0 {
        invokeTimer()
    }
} while (true == true)
