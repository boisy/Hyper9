import Testing
@testable import SwiftTurbo9

struct TestSEX {
    @Test func test_sex_positive() async throws {
        let accumulator : UInt8 = 0x10
        let cpu = CPU.create(ram: [], accb: accumulator)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .sex, addressMode: .inh)
        
        #expect(cpu.D == 0x0010)
        
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
    }
    
    @Test func test_sex_negative() async throws {
        let accumulator : UInt8 = 0x9E
        let cpu = CPU.create(ram: [], accb: accumulator)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .sex, addressMode: .inh)
        
        #expect(cpu.D == 0xFF9E)
        
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.zero) == false)
    }
    
    @Test func test_sex_zero() async throws {
        let accumulator : UInt8 = 0x00
        let cpu = CPU.create(ram: [], accb: accumulator)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .sex, addressMode: .inh)
        
        #expect(cpu.D == 0x0000)
        
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == true)
    }
}
