import Testing
@testable import Turbo9Sim

struct TestBCC {
    @Test func test_bcc_with_carry_clear() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.carry, false)
        try cpu.perform(instruction: .bcc, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
    
    @Test func test_bcc_with_carry_set() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.carry, true)
        try cpu.perform(instruction: .bcc, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
}

struct TestLBCC {
    @Test func test_lbcc_with_carry_clear() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.carry, false)
        try cpu.perform(instruction: .lbcc, addressMode: .rel16)
        
        #expect(cpu.PC == 0x12)
    }
    
    @Test func test_lbcc_with_carry_set() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.carry, true)
        try cpu.perform(instruction: .lbcc, addressMode: .rel16)
        
        #expect(cpu.PC == 0x2)
    }
}

struct TestBCS {
    @Test func test_bcs_with_carry_clear() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.carry, false)
        try cpu.perform(instruction: .bcs, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
    
    @Test func test_bcs_with_carry_set() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.carry, true)
        try cpu.perform(instruction: .bcs, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
}

struct TestLBCS {
    @Test func test_lbcs_with_carry_clear() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.carry, false)
        try cpu.perform(instruction: .lbcs, addressMode: .rel16)
        
        #expect(cpu.PC == 0x02)
    }
    
    @Test func test_lbcs_with_carry_set() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.carry, true)
        try cpu.perform(instruction: .lbcs, addressMode: .rel16)
        
        #expect(cpu.PC == 0x12)
    }
}

struct TestBEQ {
    @Test func test_beq_with_zero_clear() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.zero, false)
        try cpu.perform(instruction: .beq, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
    
    @Test func test_beq_with_zero_set() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.zero, true)
        try cpu.perform(instruction: .beq, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
}

struct TestLBEQ {
    @Test func test_lbeq_with_zero_clear() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.zero, false)
        try cpu.perform(instruction: .lbeq, addressMode: .rel16)
        
        #expect(cpu.PC == 0x02)
    }
    
    @Test func test_lbeq_with_zero_set() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.zero, true)
        try cpu.perform(instruction: .lbeq, addressMode: .rel16)
        
        #expect(cpu.PC == 0x12)
    }
}
    
struct TestBGE {
    @Test func test_bge_with_negative_clear_and_overflow_clear() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, false)
        cpu.setCC(.overflow, false)
        try cpu.perform(instruction: .bge, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
    
    @Test func test_bge_with_negative_clear_and_overflow_set() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, false)
        cpu.setCC(.overflow, true)
        try cpu.perform(instruction: .bge, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
    
    @Test func test_bge_with_negative_set_and_overflow_clear() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, true)
        cpu.setCC(.overflow, false)
        try cpu.perform(instruction: .bge, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
    
    @Test func test_bge_with_negative_set_and_overflow_set() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, true)
        cpu.setCC(.overflow, true)
        try cpu.perform(instruction: .bge, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
}

struct TestLBGE {
    @Test func test_lbge_with_negative_clear_and_overflow_clear() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, false)
        cpu.setCC(.overflow, false)
        try cpu.perform(instruction: .lbge, addressMode: .rel16)
        
        #expect(cpu.PC == 0x12)
    }
    
    @Test func test_lbge_with_negative_clear_and_overflow_set() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, false)
        cpu.setCC(.overflow, true)
        try cpu.perform(instruction: .lbge, addressMode: .rel16)
        
        #expect(cpu.PC == 0x02)
    }
    
    @Test func test_lbge_with_negative_set_and_overflow_clear() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, true)
        cpu.setCC(.overflow, false)
        try cpu.perform(instruction: .lbge, addressMode: .rel16)
        
        #expect(cpu.PC == 0x02)
    }
    
    @Test func test_lbge_with_negative_set_and_overflow_set() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, true)
        cpu.setCC(.overflow, true)
        try cpu.perform(instruction: .lbge, addressMode: .rel16)
        
        #expect(cpu.PC == 0x12)
    }
}

struct TestBGT {
    @Test func test_bgt_with_negative_clear_and_overflow_clear_and_zero_clear() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, false)
        cpu.setCC(.overflow, false)
        cpu.setCC(.zero, false)
        try cpu.perform(instruction: .bgt, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
    
    @Test func test_bgt_with_negative_clear_and_overflow_clear_and_zero_set() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, false)
        cpu.setCC(.overflow, false)
        cpu.setCC(.zero, true)
        try cpu.perform(instruction: .bgt, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
    
    @Test func test_bgt_with_negative_clear_and_overflow_set_and_zero_clear() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, false)
        cpu.setCC(.overflow, true)
        cpu.setCC(.zero, false)
        try cpu.perform(instruction: .bgt, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
    
    @Test func test_bgt_with_negative_clear_and_overflow_set_and_zero_set() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, false)
        cpu.setCC(.overflow, true)
        cpu.setCC(.zero, true)
        try cpu.perform(instruction: .bgt, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
    
    @Test func test_bgt_with_negative_set_and_overflow_clear_and_zero_clear() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, true)
        cpu.setCC(.overflow, false)
        cpu.setCC(.zero, false)
        try cpu.perform(instruction: .bgt, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
    
    @Test func test_bgt_with_negative_set_and_overflow_clear_and_zero_set() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, true)
        cpu.setCC(.overflow, false)
        cpu.setCC(.zero, true)
        try cpu.perform(instruction: .bgt, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
    
    @Test func test_bgt_with_negative_set_and_overflow_set_and_zero_clear() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, true)
        cpu.setCC(.overflow, true)
        cpu.setCC(.zero, false)
        try cpu.perform(instruction: .bgt, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
    
    @Test func test_bgt_with_negative_set_and_overflow_set_and_zero_set() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, true)
        cpu.setCC(.overflow, true)
        cpu.setCC(.zero, true)
        try cpu.perform(instruction: .bgt, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
}

struct TestLBGT {
    @Test func test_lbgt_with_negative_clear_and_overflow_clear_and_zero_clear() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, false)
        cpu.setCC(.overflow, false)
        cpu.setCC(.zero, false)
        try cpu.perform(instruction: .lbgt, addressMode: .rel16)
        
        #expect(cpu.PC == 0x12)
    }
    
    @Test func test_lbgt_with_negative_clear_and_overflow_clear_and_zero_set() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, false)
        cpu.setCC(.overflow, false)
        cpu.setCC(.zero, true)
        try cpu.perform(instruction: .lbgt, addressMode: .rel16)
        
        #expect(cpu.PC == 0x02)
    }
    
    @Test func test_lbgt_with_negative_clear_and_overflow_set_and_zero_clear() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, false)
        cpu.setCC(.overflow, true)
        cpu.setCC(.zero, false)
        try cpu.perform(instruction: .lbgt, addressMode: .rel16)
        
        #expect(cpu.PC == 0x02)
    }
    
    @Test func test_lbgt_with_negative_clear_and_overflow_set_and_zero_set() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, false)
        cpu.setCC(.overflow, true)
        cpu.setCC(.zero, true)
        try cpu.perform(instruction: .lbgt, addressMode: .rel16)
        
        #expect(cpu.PC == 0x02)
    }
    
    @Test func test_lbgt_with_negative_set_and_overflow_clear_and_zero_clear() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, true)
        cpu.setCC(.overflow, false)
        cpu.setCC(.zero, false)
        try cpu.perform(instruction: .lbgt, addressMode: .rel16)
        
        #expect(cpu.PC == 0x02)
    }
    
    @Test func test_lbgt_with_negative_set_and_overflow_clear_and_zero_set() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, true)
        cpu.setCC(.overflow, false)
        cpu.setCC(.zero, true)
        try cpu.perform(instruction: .lbgt, addressMode: .rel16)
        
        #expect(cpu.PC == 0x02)
    }
    
    @Test func test_lbgt_with_negative_set_and_overflow_set_and_zero_clear() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, true)
        cpu.setCC(.overflow, true)
        cpu.setCC(.zero, false)
        try cpu.perform(instruction: .lbgt, addressMode: .rel16)
        
        #expect(cpu.PC == 0x12)
    }
    
    @Test func test_lbgt_with_negative_set_and_overflow_set_and_zero_set() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, true)
        cpu.setCC(.overflow, true)
        cpu.setCC(.zero, true)
        try cpu.perform(instruction: .lbgt, addressMode: .rel16)
        
        #expect(cpu.PC == 0x02)
    }
}

struct TestBHI {
    @Test func test_bhi_with_zero_clear_and_carry_clear() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.zero, false)
        cpu.setCC(.carry, false)
        try cpu.perform(instruction: .bhi, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
    
    @Test func test_bhi_with_zero_clear_and_carry_set() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.zero, false)
        cpu.setCC(.carry, true)
        try cpu.perform(instruction: .bhi, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
    
    @Test func test_bhi_with_zero_set_and_carry_clear() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.zero, true)
        cpu.setCC(.carry, false)
        try cpu.perform(instruction: .bhi, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
    
    @Test func test_bhi_with_zero_set_and_carry_set() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.zero, true)
        cpu.setCC(.carry, true)
        try cpu.perform(instruction: .bhi, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
}

struct TestLBHI {
    @Test func test_lbhi_with_zero_clear_and_carry_clear() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.zero, false)
        cpu.setCC(.carry, false)
        try cpu.perform(instruction: .lbhi, addressMode: .rel16)
        
        #expect(cpu.PC == 0x12)
    }
    
    @Test func test_lbhi_with_zero_clear_and_carry_set() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.zero, false)
        cpu.setCC(.carry, true)
        try cpu.perform(instruction: .lbhi, addressMode: .rel16)
        
        #expect(cpu.PC == 0x02)
    }
    
    @Test func test_lbhi_with_zero_set_and_carry_clear() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.zero, true)
        cpu.setCC(.carry, false)
        try cpu.perform(instruction: .lbhi, addressMode: .rel16)
        
        #expect(cpu.PC == 0x02)
    }
    
    @Test func test_lbhi_with_zero_set_and_carry_set() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.zero, true)
        cpu.setCC(.carry, true)
        try cpu.perform(instruction: .lbhi, addressMode: .rel16)
        
        #expect(cpu.PC == 0x02)
    }
}

struct TestBLE {
    @Test func test_ble_with_negative_clear_and_overflow_clear_and_zero_clear() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, false)
        cpu.setCC(.overflow, false)
        cpu.setCC(.zero, false)
        try cpu.perform(instruction: .ble, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
    
    @Test func test_ble_with_negative_clear_and_overflow_clear_and_zero_set() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, false)
        cpu.setCC(.overflow, false)
        cpu.setCC(.zero, true)
        try cpu.perform(instruction: .ble, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
    
    @Test func test_ble_with_negative_clear_and_overflow_set_and_zero_clear() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, false)
        cpu.setCC(.overflow, true)
        cpu.setCC(.zero, false)
        try cpu.perform(instruction: .ble, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
    
    @Test func test_ble_with_negative_clear_and_overflow_set_and_zero_set() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, false)
        cpu.setCC(.overflow, true)
        cpu.setCC(.zero, true)
        try cpu.perform(instruction: .ble, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
    
    @Test func test_ble_with_negative_set_and_overflow_clear_and_zero_clear() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, true)
        cpu.setCC(.overflow, false)
        cpu.setCC(.zero, false)
        try cpu.perform(instruction: .ble, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
    
    @Test func test_ble_with_negative_set_and_overflow_clear_and_zero_set() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, true)
        cpu.setCC(.overflow, false)
        cpu.setCC(.zero, true)
        try cpu.perform(instruction: .ble, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
    
    @Test func test_ble_with_negative_set_and_overflow_set_and_zero_clear() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, true)
        cpu.setCC(.overflow, true)
        cpu.setCC(.zero, false)
        try cpu.perform(instruction: .ble, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
    
    @Test func test_ble_with_negative_set_and_overflow_set_and_zero_set() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, true)
        cpu.setCC(.overflow, true)
        cpu.setCC(.zero, true)
        try cpu.perform(instruction: .ble, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
}

struct TestLBLE {
    @Test func test_lble_with_negative_clear_and_overflow_clear_and_zero_clear() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, false)
        cpu.setCC(.overflow, false)
        cpu.setCC(.zero, false)
        try cpu.perform(instruction: .lble, addressMode: .rel16)
        
        #expect(cpu.PC == 0x02)
    }
    
    @Test func test_lble_with_negative_clear_and_overflow_clear_and_zero_set() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, false)
        cpu.setCC(.overflow, false)
        cpu.setCC(.zero, true)
        try cpu.perform(instruction: .lble, addressMode: .rel16)
        
        #expect(cpu.PC == 0x12)
    }
    
    @Test func test_lble_with_negative_clear_and_overflow_set_and_zero_clear() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, false)
        cpu.setCC(.overflow, true)
        cpu.setCC(.zero, false)
        try cpu.perform(instruction: .lble, addressMode: .rel16)
        
        #expect(cpu.PC == 0x12)
    }
    
    @Test func test_lble_with_negative_clear_and_overflow_set_and_zero_set() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, false)
        cpu.setCC(.overflow, true)
        cpu.setCC(.zero, true)
        try cpu.perform(instruction: .lble, addressMode: .rel16)
        
        #expect(cpu.PC == 0x12)
    }
    
    @Test func test_lble_with_negative_set_and_overflow_clear_and_zero_clear() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, true)
        cpu.setCC(.overflow, false)
        cpu.setCC(.zero, false)
        try cpu.perform(instruction: .lble, addressMode: .rel16)
        
        #expect(cpu.PC == 0x12)
    }
    
    @Test func test_lble_with_negative_set_and_overflow_clear_and_zero_set() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, true)
        cpu.setCC(.overflow, false)
        cpu.setCC(.zero, true)
        try cpu.perform(instruction: .lble, addressMode: .rel16)
        
        #expect(cpu.PC == 0x12)
    }
    
    @Test func test_lble_with_negative_set_and_overflow_set_and_zero_clear() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, true)
        cpu.setCC(.overflow, true)
        cpu.setCC(.zero, false)
        try cpu.perform(instruction: .lble, addressMode: .rel16)
        
        #expect(cpu.PC == 0x02)
    }
    
    @Test func test_lble_with_negative_set_and_overflow_set_and_zero_set() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, true)
        cpu.setCC(.overflow, true)
        cpu.setCC(.zero, true)
        try cpu.perform(instruction: .lble, addressMode: .rel16)
        
        #expect(cpu.PC == 0x12)
    }
}

struct TestBLO {
    @Test func test_blo_with_carry_set() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.carry, true)
        try cpu.perform(instruction: .blo, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
    
    @Test func test_blo_with_carry_clear() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.carry, false)
        try cpu.perform(instruction: .blo, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
}

struct TestLBLO {
    @Test func test_lblo_with_carry_set() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.carry, true)
        try cpu.perform(instruction: .lblo, addressMode: .rel16)
        
        #expect(cpu.PC == 0x12)
    }
    
    @Test func test_blo_with_carry_clear() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.carry, false)
        try cpu.perform(instruction: .lblo, addressMode: .rel16)
        
        #expect(cpu.PC == 0x02)
    }
}

struct TestBLS {
    @Test func test_bls_with_zero_clear_and_carry_clear() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.zero, false)
        cpu.setCC(.carry, false)
        try cpu.perform(instruction: .bls, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
    
    @Test func test_bls_with_zero_clear_and_carry_set() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.zero, false)
        cpu.setCC(.carry, true)
        try cpu.perform(instruction: .bls, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
    
    @Test func test_bls_with_zero_set_and_carry_clear() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.zero, true)
        cpu.setCC(.carry, false)
        try cpu.perform(instruction: .bls, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
    
    @Test func test_bls_with_zero_set_and_carry_set() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.zero, true)
        cpu.setCC(.carry, true)
        try cpu.perform(instruction: .bls, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
}

struct TestLBLS {
    @Test func test_lbls_with_zero_clear_and_carry_clear() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.zero, false)
        cpu.setCC(.carry, false)
        try cpu.perform(instruction: .lbls, addressMode: .rel16)
        
        #expect(cpu.PC == 0x02)
    }
    
    @Test func test_lbls_with_zero_clear_and_carry_set() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.zero, false)
        cpu.setCC(.carry, true)
        try cpu.perform(instruction: .lbls, addressMode: .rel16)
        
        #expect(cpu.PC == 0x12)
    }
    
    @Test func test_lbls_with_zero_set_and_carry_clear() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.zero, true)
        cpu.setCC(.carry, false)
        try cpu.perform(instruction: .lbls, addressMode: .rel16)
        
        #expect(cpu.PC == 0x12)
    }
    
    @Test func test_lbls_with_zero_set_and_carry_set() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.zero, true)
        cpu.setCC(.carry, true)
        try cpu.perform(instruction: .lbls, addressMode: .rel16)
        
        #expect(cpu.PC == 0x12)
    }
}

struct TestBLT {
    @Test func test_blt_with_negative_clear_and_overflow_clear() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, false)
        cpu.setCC(.overflow, false)
        try cpu.perform(instruction: .blt, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
    
    @Test func test_blt_with_negative_clear_and_overflow_set() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, false)
        cpu.setCC(.overflow, true)
        try cpu.perform(instruction: .blt, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
    
    @Test func test_blt_with_negative_set_and_overflow_clear() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, true)
        cpu.setCC(.overflow, false)
        try cpu.perform(instruction: .blt, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
    
    @Test func test_blt_with_negative_set_and_overflow_set() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, true)
        cpu.setCC(.overflow, true)
        try cpu.perform(instruction: .blt, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
}

struct TestLBLT {
    @Test func test_lblt_with_negative_clear_and_overflow_clear() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, false)
        cpu.setCC(.overflow, false)
        try cpu.perform(instruction: .lblt, addressMode: .rel16)
        
        #expect(cpu.PC == 0x02)
    }
    
    @Test func test_lblt_with_negative_clear_and_overflow_set() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, false)
        cpu.setCC(.overflow, true)
        try cpu.perform(instruction: .lblt, addressMode: .rel16)
        
        #expect(cpu.PC == 0x12)
    }
    
    @Test func test_lblt_with_negative_set_and_overflow_clear() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, true)
        cpu.setCC(.overflow, false)
        try cpu.perform(instruction: .lblt, addressMode: .rel16)
        
        #expect(cpu.PC == 0x12)
    }
    
    @Test func test_lblt_with_negative_set_and_overflow_set() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, true)
        cpu.setCC(.overflow, true)
        try cpu.perform(instruction: .lblt, addressMode: .rel16)
        
        #expect(cpu.PC == 0x02)
    }
}

struct TestBMI {
    @Test func test_bmi_with_negative_clear() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, false)
        try cpu.perform(instruction: .bmi, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
    
    @Test func test_bmi_with_negative_set() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, true)
        try cpu.perform(instruction: .bmi, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
}

struct TestLBMI {
    @Test func test_lbmi_with_negative_clear() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, false)
        try cpu.perform(instruction: .bmi, addressMode: .rel16)
        
        #expect(cpu.PC == 0x02)
    }
    
    @Test func test_lbmi_with_negative_set() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, true)
        try cpu.perform(instruction: .bmi, addressMode: .rel16)
        
        #expect(cpu.PC == 0x12)
    }
}

struct TestBNE {
    @Test func test_bne_with_zero_clear() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.zero, false)
        try cpu.perform(instruction: .bne, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
    
    @Test func test_bne_with_zero_set() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.zero, true)
        try cpu.perform(instruction: .bne, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
}

struct TestLBNE {
    @Test func test_lbne_with_zero_clear() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.zero, false)
        try cpu.perform(instruction: .lbne, addressMode: .rel16)
        
        #expect(cpu.PC == 0x12)
    }
    
    @Test func test_lbne_with_zero_set() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.zero, true)
        try cpu.perform(instruction: .lbne, addressMode: .rel16)
        
        #expect(cpu.PC == 0x02)
    }
}

struct TestBPL {
    @Test func test_bpl_with_negative_clear() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, false)
        try cpu.perform(instruction: .bpl, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
    
    @Test func test_bpl_with_negative_set() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.negative, true)
        try cpu.perform(instruction: .bpl, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
}

struct TestLBPL {
    @Test func test_lbpl_with_negative_clear() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, false)
        try cpu.perform(instruction: .lbpl, addressMode: .rel16)
        
        #expect(cpu.PC == 0x12)
    }
    
    @Test func test_lbpl_with_negative_set() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.negative, true)
        try cpu.perform(instruction: .lbpl, addressMode: .rel16)
        
        #expect(cpu.PC == 0x02)
    }
}

struct TestBRA {
    @Test func test_bra() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        try cpu.perform(instruction: .bra, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
}

struct TestLBRA {
    @Test func test_lbra() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        try cpu.perform(instruction: .lbra, addressMode: .rel16)
        
        #expect(cpu.PC == 0x12)
    }
}

struct TestBRN {
    @Test func test_brn() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        try cpu.perform(instruction: .brn, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
}

struct TestLBRN {
    @Test func test_lbrn() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        try cpu.perform(instruction: .lbrn, addressMode: .rel16)
        
        #expect(cpu.PC == 0x02)
    }
}

struct TestBSR {
    @Test func test_bsr() async throws {
        let cpu = CPU.create(ram: [0x01, 0x39, 0x00, 0x00], stackPointer: 0x0004)
        cpu.setupAddressing(using: .rel8)
        
        try cpu.perform(instruction: .bsr, addressMode: .rel8)
        
        #expect(cpu.PC == 0x02)
        #expect(cpu.readWord(0x0002) == 0x0001)
    }
}
    
struct TestLBSR {
    @Test func test_bsr() async throws {
        let cpu = CPU.create(ram: [0x00, 0x02, 0x39, 0x00, 0x00], stackPointer: 0x0005)
        cpu.setupAddressing(using: .rel16)
        
        try cpu.perform(instruction: .lbsr, addressMode: .rel16)
        
        #expect(cpu.PC == 0x04)
        #expect(cpu.readWord(0x0003) == 0x0002)
    }
}
    
struct TestBVC {
    @Test func test_bvc_with_noverflow_clear() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.overflow, false)
        try cpu.perform(instruction: .bvc, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
    
    @Test func test_bvc_with_overflow_set() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.overflow, true)
        try cpu.perform(instruction: .bvc, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
}

struct TestLBVC {
    @Test func test_lbvc_with_noverflow_clear() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.overflow, false)
        try cpu.perform(instruction: .lbvc, addressMode: .rel16)
        
        #expect(cpu.PC == 0x12)
    }
    
    @Test func test_lbvc_with_overflow_set() async throws {
        let cpu = CPU.create(ram: [0x00, 0x10])
        cpu.setupAddressing(using: .rel16)
        
        cpu.setCC(.overflow, true)
        try cpu.perform(instruction: .lbvc, addressMode: .rel16)
        
        #expect(cpu.PC == 0x02)
    }
}

struct TestBVS {
    @Test func test_bvs_with_noverflow_clear() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.overflow, false)
        try cpu.perform(instruction: .bvs, addressMode: .rel8)
        
        #expect(cpu.PC == 0x01)
    }
    
    @Test func test_bvs_with_overflow_set() async throws {
        let cpu = CPU.create(ram: [0x10])
        cpu.setupAddressing(using: .rel8)
        
        cpu.setCC(.overflow, true)
        try cpu.perform(instruction: .bvs, addressMode: .rel8)
        
        #expect(cpu.PC == 0x11)
    }
    
    struct TesLBVS {
        @Test func test_lbvs_with_noverflow_clear() async throws {
            let cpu = CPU.create(ram: [0x00, 0x10])
            cpu.setupAddressing(using: .rel16)
            
            cpu.setCC(.overflow, false)
            try cpu.perform(instruction: .lbvs, addressMode: .rel16)
            
            #expect(cpu.PC == 0x02)
        }
        
        @Test func test_blvs_with_overflow_set() async throws {
            let cpu = CPU.create(ram: [0x00, 0x10])
            cpu.setupAddressing(using: .rel16)
            
            cpu.setCC(.overflow, true)
            try cpu.perform(instruction: .lbvs, addressMode: .rel16)
            
            #expect(cpu.PC == 0x12)
        }
    }
}
