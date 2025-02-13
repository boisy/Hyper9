import Testing
@testable import Turbo9Sim

struct TestASLA {
    @Test func test_asla() async throws {
        let accumulator : UInt8 = 0x10
        let cpu = CPU.create(ram: [0], acca: accumulator)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .asla, addressMode: .inh)
        
        #expect(cpu.A == accumulator << 1)
        
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
    }
    
    @Test func test_asla_zero_true_overflow_true() async throws {
        let accumulator : UInt8 = 0x80
        let cpu = CPU.create(ram: [0], acca: accumulator)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .asla, addressMode: .inh)
        
        #expect(cpu.A == accumulator << 1)
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == true)
        #expect(cpu.readCC(.overflow) == true)
    }
    
    @Test func test_asla_negative_true_overflow_true() async throws {
        let accumulator : UInt8 = 0x40
        let cpu = CPU.create(ram: [0], acca: accumulator)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .asla, addressMode: .inh)
        
        #expect(cpu.A == accumulator << 1)
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == true)
    }
}

struct TestASLB {
    @Test func test_aslb() async throws {
        let accumulator : UInt8 = 0x10
        let cpu = CPU.create(ram: [0], accb: accumulator)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .aslb, addressMode: .inh)
        
        #expect(cpu.B == accumulator << 1)
        
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
    }
    
    @Test func test_aslb_zero_true_overflow_true() async throws {
        let accumulator : UInt8 = 0x80
        let cpu = CPU.create(ram: [0], accb: accumulator)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .aslb, addressMode: .inh)
        
        #expect(cpu.B == accumulator << 1)
        
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == true)
        #expect(cpu.readCC(.overflow) == true)
    }
    
    @Test func test_aslb_negative_true_overflow_true() async throws {
        let accumulator : UInt8 = 0x40
        let cpu = CPU.create(ram: [0], accb: accumulator)
        cpu.setupAddressing(using: .inh)
        
        try cpu.perform(instruction: .aslb, addressMode: .inh)
        
        #expect(cpu.B == accumulator << 1)
        
        #expect(cpu.readCC(.negative) == true)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == true)
    }
}

struct TestASL {
    @Test func test_asl_direct() async throws {
        let cpu = CPU.create(ram: [0x01, 0x33])
        cpu.setupAddressing(using: .dir)
        
        try cpu.perform(instruction: .asl, addressMode: .dir)
        
        #expect(cpu.readByte(1) == 0x66)
        
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
    }
    
    @Test func test_asl_extended() async throws {
        let cpu = CPU.create(ram: [0x00, 0x02, 0x02])
        cpu.setupAddressing(using: .ext)
        
        try cpu.perform(instruction: .asl, addressMode: .ext)
        
        #expect(cpu.readByte(0x02) == 0x04)
        
        #expect(cpu.readCC(.negative) == false)
        #expect(cpu.readCC(.zero) == false)
        #expect(cpu.readCC(.overflow) == false)
    }
}
