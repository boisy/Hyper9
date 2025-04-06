//
//  main.swift
//  hyper9-cmd
//
//  Created by Boisy Pitre on 3/9/25.
//

import Foundation
import Darwin
import Turbo9Sim

var inputBuffer = ""

// Set terminal to raw mode to capture individual key presses
func enableRawMode() {
    let attrs = UnsafeMutablePointer<termios>.allocate(capacity: 1)
    tcgetattr(STDIN_FILENO, attrs)
    var raw = attrs.pointee
    raw.c_lflag &= ~(UInt(ECHO | ICANON)) // Turn off echo and canonical mode
    tcsetattr(STDIN_FILENO, TCSANOW, &raw)
    attrs.deallocate()
}

// Restore terminal to original mode
func disableRawMode() {
    let attrs = UnsafeMutablePointer<termios>.allocate(capacity: 1)
    tcgetattr(STDIN_FILENO, attrs)
    var cooked = attrs.pointee
    cooked.c_lflag |= (UInt(ECHO | ICANON))
    tcsetattr(STDIN_FILENO, TCSANOW, &cooked)
    attrs.deallocate()
}

public func invokeTimerIRQ() {
    // Set the bit indicating the timer has fired
    let value = turbo9.bus.read(0xFF02)
    turbo9.bus.write(0xFF02, data: value | 0x01)
    
    // If the timer control register's "interrupt on timer" is set, assert the IRQ
    if (turbo9.bus.read(0xFF03) & 0x01) == 0x01 {
        turbo9.assertIRQ()
    }
}

public func invokeInputIRQ() {
    // Set the bit indicating there's an input character
    let value = turbo9.bus.read(0xFF02)
    turbo9.bus.write(0xFF02, data: 0x02)
    
    // If the interrupt control register's "interrupt on input" is set, assert the IRQ
    if (turbo9.bus.read(0xFF03) & 0x02) == 0x02 {
        turbo9.assertIRQ()
    }
}


var timerRunning = false
var inputIRQEnabled = false
let turbo9 = Disassembler()
try turbo9.load(url: URL(fileURLWithPath: "/Users/boisy/Projects/turbos/ports/turbo9sim/turbos_full.img"))

let outputHandler = BusWriteHandler(address: 0xFF00, callback: { value in
    print(String(format: "%c", value), terminator: "")
})

let irqStatusHandler = BusWriteHandler(address: 0xFF02, callback: { value in
    // Writing 1 to bit 0 deasserts timer IRQ
    if (value & 0x01) == 0x01 {
        let _ = turbo9.bus.read(0xFF02, readThroughIO: true) & 0xFE
        turbo9.deassertIRQ()
    }

    // Writing 1 to bit 1 deasserts input IRQ
    if (value & 0x02) == 0x02 {
        let _ = turbo9.bus.read(0xFF02, readThroughIO: true) & 0xFD
        turbo9.deassertIRQ()
    }
})

let irqControlHandler = BusWriteHandler(address: 0xFF03, callback: { value in
    if (value & 0x01) == 0x01 {
        timerRunning = true
    } else {
        timerRunning = false
    }
    
    if (value & 0x02) == 0x02 {
        inputIRQEnabled = true
    } else {
        inputIRQEnabled = false
    }
})


enableRawMode()

let flags = fcntl(STDIN_FILENO, F_GETFL)
fcntl(STDIN_FILENO, F_SETFL, flags | O_NONBLOCK)

turbo9.bus.addWriteHandler(handler: outputHandler)
turbo9.bus.addWriteHandler(handler: irqStatusHandler)
turbo9.bus.addWriteHandler(handler: irqControlHandler)

try turbo9.reset()

func log(_ message: String) {
//    print(message)
}

turbo9.instructionClosure = log

repeat {
    if turbo9.PC == 0xf6c4 {
        turbo9.instructionClosure = log
    }
    try turbo9.step()
    if turbo9.clockCycles % 3000 == 0 {
        invokeTimerIRQ()
    }
    
    var char: UInt8 = 0
    let readBytes = read(STDIN_FILENO, &char, 1)

    if readBytes == 1 {
        if char == 10 { // Enter key (LF, \n)
            char = 13
//            break
        }
//        inputBuffer.append(Character(UnicodeScalar(char)))
        turbo9.bus.write(0xFF01, data: char)
        invokeInputIRQ()
    }
} while (true == true)

disableRawMode()
