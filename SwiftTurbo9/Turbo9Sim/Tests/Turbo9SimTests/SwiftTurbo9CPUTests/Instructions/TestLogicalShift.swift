import Testing
@testable import Turbo9Sim

struct TestLSLA {
    @Test func test_lsla() async throws {
        let accumulator : UInt8 = 0x10
        let cpu = CPU.create(ram: [0], acca: accumulator)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .lsla, addressMode: .inh)
        
        #expect(cpu.A == accumulator << 1)
        
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
    }
    
    @Test func test_lsla_zero_true_overflow_true() async throws {
        let accumulator : UInt8 = 0x80
        let cpu = CPU.create(ram: [0], acca: accumulator)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .lsla, addressMode: .inh)
        
        #expect(cpu.A == accumulator << 1)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == true)
        #expect(cpu.readCC(.overflow) == true)
    }
    
    @Test func test_lsla_negative_true_overflow_true() async throws {
        let accumulator : UInt8 = 0x40
        let cpu = CPU.create(ram: [0], acca: accumulator)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .lsla, addressMode: .inh)
        
        #expect(cpu.A == accumulator << 1)
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == true)
    }
}

struct TestLSRA {
    @Test func test_lsra() async throws {
        let accumulator : UInt8 = 0x10
        let cpu = CPU.create(ram: [0], acca: accumulator)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .lsra, addressMode: .inh)
        
        #expect(cpu.A == accumulator >> 1)
        
        #expect(cpu.readCC(.zero) == false)
    }
    
    @Test func test_lsra_zero_false() async throws {
        let accumulator : UInt8 = 0x80
        let cpu = CPU.create(ram: [0], acca: accumulator)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .lsra, addressMode: .inh)
        
        #expect(cpu.A == accumulator >> 1)
        #expect(cpu.readCC(.zero) == false)
    }
    
    @Test func test_lsra_carry_true() async throws {
        let accumulator : UInt8 = 0x01
        let cpu = CPU.create(ram: [0], acca: accumulator)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .lsra, addressMode: .inh)
        
        #expect(cpu.A == accumulator >> 1)
        #expect(cpu.readCC(.carry) == true)
    }
}

struct TestLSLB {
    @Test func test_lslb() async throws {
        let accumulator : UInt8 = 0x10
        let cpu = CPU.create(ram: [0], accb: accumulator)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .lslb, addressMode: .inh)
        
        #expect(cpu.B == accumulator << 1)
        
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
    }
    
    @Test func test_lslb_zero_true_overflow_true() async throws {
        let accumulator : UInt8 = 0x80
        let cpu = CPU.create(ram: [0], accb: accumulator)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .lslb, addressMode: .inh)
        
        #expect(cpu.B == accumulator << 1)
        
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == true)
        #expect(cpu.readCC(.overflow) == true)
    }
    
    @Test func test_lslb_negative_true_overflow_true() async throws {
        let accumulator : UInt8 = 0x40
        let cpu = CPU.create(ram: [0], accb: accumulator)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .lslb, addressMode: .inh)
        
        #expect(cpu.B == accumulator << 1)
        
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == true)
    }
}

struct TestLSL {
    @Test func test_lsl_direct() async throws {
        let cpu = CPU.create(ram: [0x01, 0x33])
        cpu.setupAddressing(using: .dir)
        
        try cpu.perform(instruction: .lsl, addressMode: .dir)
        
        #expect(cpu.readByte(1) == 0x66)
        
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
    }
    
    @Test func test_lsl_extended() async throws {
        let cpu = CPU.create(ram: [0x00, 0x02, 0x02])
        cpu.setupAddressing(using: .ext)
        
        try cpu.perform(instruction: .lsl, addressMode: .ext)
        
        #expect(cpu.readByte(0x02) == 0x04)
        
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
    }
}
