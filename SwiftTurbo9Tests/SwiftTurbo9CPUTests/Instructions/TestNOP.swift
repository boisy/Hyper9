//
//  Test.swift
//  SwiftTurbo9
//
//  Created by Boisy Pitre on 1/22/25.
//

import Testing
@testable import Turbo9Sim

struct TestNOP {

    @Test func NOP() async throws {
        let cpu = CPU.create(ram: [], acca: 0x08)
        cpu.setupAddressing(using: .inh)

        try cpu.perform(instruction: .nop, addressMode: .inh)
    }
}
