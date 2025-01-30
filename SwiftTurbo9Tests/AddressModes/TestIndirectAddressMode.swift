import Testing
@testable import SwiftTurbo9

struct Test0BitConstantOffsetFromRegisterAddressMode {
    @Test func test_0_bit_offset_of_x() async throws {
        let cpu = CPU.create(ram: [0x84])
        
        cpu.X = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == cpu.X)
    }
    
    @Test func test_0_bit_offset_of_y() async throws {
        let cpu = CPU.create(ram: [0xA4])
        
        cpu.Y = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == cpu.Y)
    }
    
    @Test func test_0_bit_offset_of_u() async throws {
        let cpu = CPU.create(ram: [0xC4])
        
        cpu.U = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == cpu.U)
    }
    
    @Test func test_0_bit_offset_of_s() async throws {
        let cpu = CPU.create(ram: [0xE4])
        
        cpu.S = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == cpu.S)
    }
}

struct Test5BitConstantOffsetFromRegisterAddressMode {
    @Test func test_positive_5_bit_offset_of_x() async throws {
        let cpu = CPU.create(ram: [0x06])
        
        cpu.X = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == UInt16(truncatingIfNeeded: Int(cpu.X) + Int(6)))
    }
    
    @Test func test_negative_5_bit_offset_of_x() async throws {
        let cpu = CPU.create(ram: [0x16])
        
        cpu.X = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == UInt16(truncatingIfNeeded: Int(cpu.X) + Int(-10)))
    }
    
    @Test func test_positive_5_bit_offset_of_y() async throws {
        let cpu = CPU.create(ram: [0x24])
        
        cpu.Y = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == UInt16(truncatingIfNeeded: Int(cpu.Y) + Int(4)))
    }
    
    @Test func test_negative_5_bit_offset_of_y() async throws {
        let cpu = CPU.create(ram: [0x3F])
        
        cpu.Y = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == UInt16(truncatingIfNeeded: Int(cpu.Y) + Int(-1)))
    }
    
    @Test func test_positive_5_bit_offset_of_u() async throws {
        let cpu = CPU.create(ram: [0x44])
        
        cpu.U = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == UInt16(truncatingIfNeeded: Int(cpu.U) + Int(4)))
    }
    
    @Test func test_negative_5_bit_offset_of_u() async throws {
        let cpu = CPU.create(ram: [0x5F])
        
        cpu.U = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == UInt16(truncatingIfNeeded: Int(cpu.U) + Int(-1)))
    }
    
    @Test func test_positive_5_bit_offset_of_s() async throws {
        let cpu = CPU.create(ram: [0x64])
        
        cpu.S = 0xFFFF
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == UInt16(truncatingIfNeeded: Int(cpu.S) + Int(4)))
    }
    
    @Test func test_negative_5_bit_offset_of_s() async throws {
        let cpu = CPU.create(ram: [0x7F])
        
        cpu.S = 0x0000
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == UInt16(truncatingIfNeeded: Int(cpu.S) + Int(-1)))
    }
}

struct Test8BitConstantOffsetFromRegisterAddressMode {
    @Test func test_positive_8_bit_offset_of_x() async throws {
        let constantValue : UInt8 = 0x71
        let cpu = CPU.create(ram: [0x88, constantValue])
        
        cpu.X = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == UInt16(truncatingIfNeeded: Int(cpu.X) + Int(constantValue.asSigned)))
    }
    
    @Test func test_negative_8_bit_offset_of_x() async throws {
        let constantValue : UInt8 = 0xEF
        let cpu = CPU.create(ram: [0x88, constantValue])
        
        cpu.X = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == UInt16(truncatingIfNeeded: Int(cpu.X) + Int(constantValue.asSigned)))
    }
    
    @Test func test_positive_8_bit_offset_of_y() async throws {
        let constantValue : UInt8 = 0x33
        let cpu = CPU.create(ram: [0xA8, constantValue])
        
        cpu.Y = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == UInt16(truncatingIfNeeded: Int(cpu.Y) + Int(constantValue.asSigned)))
    }
    
    @Test func test_negative_8_bit_offset_of_y() async throws {
        let constantValue : UInt8 = 0xCF
        let cpu = CPU.create(ram: [0xA8, constantValue])
        
        cpu.Y = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == UInt16(truncatingIfNeeded: Int(cpu.Y) + Int(constantValue.asSigned)))
    }
    
    @Test func test_positive_8_bit_offset_of_u() async throws {
        let constantValue : UInt8 = 0x33
        let cpu = CPU.create(ram: [0xC8, constantValue])
        
        cpu.U = 0xFFF0
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == UInt16(truncatingIfNeeded: Int(cpu.U) + Int(constantValue.asSigned)))
    }
    
    @Test func test_negative_8_bit_offset_of_u() async throws {
        let constantValue : UInt8 = 0xCF
        let cpu = CPU.create(ram: [0xC8, constantValue])
        
        cpu.U = 0x0000
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == UInt16(truncatingIfNeeded: Int(cpu.U) + Int(constantValue.asSigned)))
    }
    
    @Test func test_positive_8_bit_offset_of_s() async throws {
        let constantValue : UInt8 = 0x43
        let cpu = CPU.create(ram: [0xE8, constantValue])
        
        cpu.S = 0x7FF0
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == UInt16(truncatingIfNeeded: Int(cpu.S) + Int(constantValue.asSigned)))
    }
    
    @Test func test_negative_8_bit_offset_of_s() async throws {
        let constantValue : UInt8 = 0x9F
        let cpu = CPU.create(ram: [0xE8, constantValue])
        
        cpu.S = 0x1000
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == UInt16(truncatingIfNeeded: Int(cpu.S) + Int(constantValue.asSigned)))
    }
}

struct Test16BitConstantOffsetFromRegisterAddressMode {
    @Test func test_positive_16_bit_offset_of_x() async throws {
        let constantValue1 : UInt8 = 0x71
        let constantValue2 : UInt8 = 0x33
        let cpu = CPU.create(ram: [0x89, constantValue1, constantValue2])
        
        cpu.X = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        let combinedValue = UInt16(truncatingIfNeeded: UInt(cpu.X) + UInt(constantValue1) * 256 + UInt(constantValue2))
        #expect(cpu.addressAbsolute == combinedValue)
    }
    
    @Test func test_negative_16_bit_offset_of_x() async throws {
        let constantValue1 : UInt8 = 0x81
        let constantValue2 : UInt8 = 0x33
        let cpu = CPU.create(ram: [0x89, constantValue1, constantValue2])
        
        cpu.X = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        let combinedValue = UInt16(truncatingIfNeeded: UInt(cpu.X) + UInt(constantValue1) * 256 + UInt(constantValue2))
        #expect(cpu.addressAbsolute == combinedValue)
    }
    
    @Test func test_positive_16_bit_offset_of_y() async throws {
        let constantValue1 : UInt8 = 0x71
        let constantValue2 : UInt8 = 0x33
        let cpu = CPU.create(ram: [0xA9, constantValue1, constantValue2])
        
        cpu.Y = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        let combinedValue = UInt16(truncatingIfNeeded: UInt(cpu.Y) + UInt(constantValue1) * 256 + UInt(constantValue2))
        #expect(cpu.addressAbsolute == combinedValue)
    }
    
    @Test func test_negative_16_bit_offset_of_y() async throws {
        let constantValue1 : UInt8 = 0x81
        let constantValue2 : UInt8 = 0x33
        let cpu = CPU.create(ram: [0xA9, constantValue1, constantValue2])
        
        cpu.Y = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        let combinedValue = UInt16(truncatingIfNeeded: UInt(cpu.Y) + UInt(constantValue1) * 256 + UInt(constantValue2))
        #expect(cpu.addressAbsolute == combinedValue)
    }
    
    @Test func test_positive_16_bit_offset_of_u() async throws {
        let constantValue1 : UInt8 = 0x71
        let constantValue2 : UInt8 = 0x33
        let cpu = CPU.create(ram: [0xC9, constantValue1, constantValue2])
        
        cpu.U = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        let combinedValue = UInt16(truncatingIfNeeded: UInt(cpu.U) + UInt(constantValue1) * 256 + UInt(constantValue2))
        #expect(cpu.addressAbsolute == combinedValue)
    }
    
    @Test func test_negative_16_bit_offset_of_u() async throws {
        let constantValue1 : UInt8 = 0x81
        let constantValue2 : UInt8 = 0x33
        let cpu = CPU.create(ram: [0xC9, constantValue1, constantValue2])
        
        cpu.U = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        let combinedValue = UInt16(truncatingIfNeeded: UInt(cpu.U) + UInt(constantValue1) * 256 + UInt(constantValue2))
        #expect(cpu.addressAbsolute == combinedValue)
    }
    
    @Test func test_positive_16_bit_offset_of_s() async throws {
        let constantValue1 : UInt8 = 0x71
        let constantValue2 : UInt8 = 0x33
        let cpu = CPU.create(ram: [0xE9, constantValue1, constantValue2])
        
        cpu.S = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        let combinedValue = UInt16(truncatingIfNeeded: UInt(cpu.S) + UInt(constantValue1) * 256 + UInt(constantValue2))
        #expect(cpu.addressAbsolute == combinedValue)
    }
    
    @Test func test_negative_16_bit_offset_of_s() async throws {
        let constantValue1 : UInt8 = 0x81
        let constantValue2 : UInt8 = 0x33
        let cpu = CPU.create(ram: [0xE9, constantValue1, constantValue2])
        
        cpu.S = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        let combinedValue = UInt16(truncatingIfNeeded: UInt(cpu.S) + UInt(constantValue1) * 256 + UInt(constantValue2))
        #expect(cpu.addressAbsolute == combinedValue)
    }
}

struct TestAccumulatorOffsetFromRegisterAddressMode {
    @Test func test_indirect_a_of_x() async throws {
        let cpu = CPU.create(ram: [0x86])
        
        // A is negative.
        cpu.A = 0xFD
        cpu.X = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == 0xFF00 - 3)
        
        // A is positive.
        cpu.PC = 0
        cpu.A = 0x70
        cpu.X = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == UInt16(truncatingIfNeeded: Int(cpu.X) + Int(cpu.A)))
    }
    
    @Test func test_indirect_b_of_x() async throws {
        let cpu = CPU.create(ram: [0x85])
        
        // B is negative.
        cpu.B = 0xFE
        cpu.X = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == 0xFF00 - 2)
        
        // B is positive.
        cpu.PC = 0
        cpu.B = 0x7F
        cpu.X = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == UInt16(truncatingIfNeeded: Int(cpu.X) + Int(cpu.B)))
    }
    
    @Test func test_indirect_d_of_x() async throws {
        let cpu = CPU.create(ram: [0x8B])
        
        // B is negative.
        cpu.A = 0xFF
        cpu.B = 0xFE
        cpu.X = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == 0xFF00 - 2)
        
        // D is positive.
        cpu.PC = 0
        cpu.A = 0x0
        cpu.B = 0x7F
        cpu.X = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == 0xFF7F)
    }
    
    @Test func test_indirect_d_of_y() async throws {
        let cpu = CPU.create(ram: [0xAB])
        
        // B is negative.
        cpu.A = 0xFF
        cpu.B = 0xF0
        cpu.Y = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == 0xFF00 - 16)
        
        // B is positive.
        cpu.PC = 0
        cpu.A = 0x0
        cpu.B = 0x33
        cpu.Y = 0x1F00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == 0x1F33)
    }
    
    @Test func test_indirect_a_of_u() async throws {
        let cpu = CPU.create(ram: [0xC6])
        
        // A is negative.
        cpu.A = 0xFD
        cpu.U = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == 0xFF00 - 3)
        
        // A is positive.
        cpu.PC = 0
        cpu.A = 0x70
        cpu.U = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == UInt16(truncatingIfNeeded: Int(cpu.U) + Int(cpu.A)))
    }
    
    @Test func test_indirect_b_of_u() async throws {
        let cpu = CPU.create(ram: [0xC5])
        
        // B is negative.
        cpu.B = 0xFE
        cpu.U = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == 0xFF00 - 2)
        
        // B is positive.
        cpu.PC = 0
        cpu.B = 0x7F
        cpu.U = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == UInt16(truncatingIfNeeded: Int(cpu.U) + Int(cpu.B)))
    }
    
    @Test func test_indirect_d_of_u() async throws {
        let cpu = CPU.create(ram: [0xCB])
        
        // B is negative.
        cpu.A = 0xFF
        cpu.B = 0xFE
        cpu.U = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == 0xFF00 - 2)
        
        // B is positive.
        cpu.PC = 0
        cpu.A = 0x0
        cpu.B = 0x7F
        cpu.U = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == 0xFF7F)
    }
    
    @Test func test_indirect_a_of_s() async throws {
        let cpu = CPU.create(ram: [0xE6])
        
        // A is negative.
        cpu.A = 0xFD
        cpu.S = 0xFFF0
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == 0xFFF0 - 3)
        
        // A is positive.
        cpu.PC = 0
        cpu.A = 0x70
        cpu.S = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == UInt16(truncatingIfNeeded: Int(cpu.S) + Int(cpu.A)))
    }
    
    @Test func test_indirect_b_of_s() async throws {
        let cpu = CPU.create(ram: [0xE5])
        
        // B is negative.
        cpu.B = 0xFE
        cpu.S = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == 0xFF00 - 2)
        
        // B is positive.
        cpu.PC = 0
        cpu.B = 0x7F
        cpu.S = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == UInt16(truncatingIfNeeded: Int(cpu.S) + Int(cpu.B)))
    }
    
    @Test func test_indirect_d_of_s() async throws {
        let cpu = CPU.create(ram: [0xEB])
        
        // B is negative.
        cpu.A = 0xFF
        cpu.B = 0xFE
        cpu.S = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == 0xFF00 - 2)
        
        // B is positive.
        cpu.PC = 0
        cpu.A = 0x0
        cpu.B = 0x7F
        cpu.S = 0xFF00
        cpu.setupAddressing(using: .ind)
        
        #expect(cpu.addressAbsolute == 0xFF7F)
    }
}

struct TestAutoIncrementFromRegisterAddressMode {
    struct TestAutoIncrementFromRegisterXAddressMode {
        @Test func test_x_increment_by_1() async throws {
            let cpu = CPU.create(ram: [0x80])
            
            cpu.X = 0xFF00
            cpu.setupAddressing(using: .ind)
            
            #expect(cpu.X == 0xFF01)
        }
        
        @Test func test_x_increment_by_2() async throws {
            let cpu = CPU.create(ram: [0x81])
            
            cpu.X = 0xFFFF
            cpu.setupAddressing(using: .ind)
            
            #expect(cpu.X == 0x0001)
        }
        
        @Test func test_x_decrement_by_1() async throws {
            let cpu = CPU.create(ram: [0x82])
            
            cpu.X = 0x0000
            cpu.setupAddressing(using: .ind)
            
            #expect(cpu.X == 0xFFFF)
        }
        
        @Test func test_x_decrement_by_2() async throws {
            let cpu = CPU.create(ram: [0x83])
            
            cpu.X = 0xFFFF
            cpu.setupAddressing(using: .ind)
            
            #expect(cpu.X == 0xFFFD)
        }
    }
    
    struct TestAutoIncrementFromRegisterYAddressMode {
        @Test func test_y_increment_by_1() async throws {
            let cpu = CPU.create(ram: [0xA0])
            
            cpu.Y = 0xFF00
            cpu.setupAddressing(using: .ind)
            
            #expect(cpu.Y == 0xFF01)
        }
        
        @Test func test_y_increment_by_2() async throws {
            let cpu = CPU.create(ram: [0xA1])
            
            cpu.Y = 0xFFFF
            cpu.setupAddressing(using: .ind)
            
            #expect(cpu.Y == 0x0001)
        }
        
        @Test func test_y_decrement_by_1() async throws {
            let cpu = CPU.create(ram: [0xA2])
            
            cpu.Y = 0x0000
            cpu.setupAddressing(using: .ind)
            
            #expect(cpu.Y == 0xFFFF)
        }
        
        @Test func test_y_decrement_by_2() async throws {
            let cpu = CPU.create(ram: [0xA3])
            
            cpu.Y = 0xFFFF
            cpu.setupAddressing(using: .ind)
            
            #expect(cpu.Y == 0xFFFD)
        }
    }
    
    struct TestAutoIncrementFromRegisterSAddressMode {
        @Test func test_s_increment_by_1() async throws {
            let cpu = CPU.create(ram: [0xE0])
            
            cpu.S = 0xFF00
            cpu.setupAddressing(using: .ind)
            
            #expect(cpu.S == 0xFF01)
        }
        
        @Test func test_s_increment_by_2() async throws {
            let cpu = CPU.create(ram: [0xE1])
            
            cpu.S = 0xFFFF
            cpu.setupAddressing(using: .ind)
            
            #expect(cpu.S == 0x0001)
        }
        
        @Test func test_s_decrement_by_1() async throws {
            let cpu = CPU.create(ram: [0xE2])
            
            cpu.S = 0x0000
            cpu.setupAddressing(using: .ind)
            
            #expect(cpu.S == 0xFFFF)
        }
        
        @Test func test_s_decrement_by_2() async throws {
            let cpu = CPU.create(ram: [0xE3])
            
            cpu.S = 0xFFFF
            cpu.setupAddressing(using: .ind)
            
            #expect(cpu.S == 0xFFFD)
        }
    }
    
    
    struct TestAutoIncrementFromRegisterUAddressMode {
        @Test func test_u_increment_by_1() async throws {
            let cpu = CPU.create(ram: [0xC0])
            
            cpu.U = 0xFF00
            cpu.setupAddressing(using: .ind)
            
            #expect(cpu.U == 0xFF01)
        }
        
        @Test func test_u_increment_by_2() async throws {
            let cpu = CPU.create(ram: [0xC1])
            
            cpu.U = 0xFFFF
            cpu.setupAddressing(using: .ind)
            
            #expect(cpu.U == 0x0001)
        }
        
        @Test func test_u_decrement_by_1() async throws {
            let cpu = CPU.create(ram: [0xC2])
            
            cpu.U = 0x0000
            cpu.setupAddressing(using: .ind)
            
            #expect(cpu.U == 0xFFFF)
        }
        
        @Test func test_u_decrement_by_2() async throws {
            let cpu = CPU.create(ram: [0xC3])
            
            cpu.U = 0xFFFF
            cpu.setupAddressing(using: .ind)
            
            #expect(cpu.U == 0xFFFD)
        }
    }
}
