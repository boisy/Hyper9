import Testing
@testable import SwiftTurbo9

struct TestStatusRegister {
    private var cpu = CPU(flags: 0x00)

    @Test func test_entire_flag() {
        #expect(0b0000_0000 == cpu.CC)
        #expect(cpu.readCC(.entire) == false)

        cpu.setCC(.entire, true)
        #expect(0b1000_0000 == cpu.CC)
        #expect(cpu.readCC(.entire) == true)

        cpu.setCC(.entire, false)
        #expect(0b0000_0000 == cpu.CC)
        #expect(cpu.readCC(.entire) == false)
    }

    @Test func test_firq_flag() {
        #expect(0b0000_0000 == cpu.CC)
        #expect(cpu.readCC(.firq) == false)

        cpu.setCC(.firq, true)
        #expect(0b0100_0000 == cpu.CC)
        #expect(cpu.readCC(.firq) == true)

        cpu.setCC(.firq, false)
        #expect(0b0000_0000 == cpu.CC)
        #expect(cpu.readCC(.firq) == false)
    }

    @Test func test_halfcarry_flag() {
        #expect(0b0000_0000 == cpu.CC)
        #expect(cpu.readCC(.halfcarry) == false)

        cpu.setCC(.halfcarry, true)
        #expect(0b0010_0000 == cpu.CC)
        #expect(cpu.readCC(.halfcarry) == true)

        cpu.setCC(.halfcarry, false)
        #expect(0b0000_0000 == cpu.CC)
        #expect(cpu.readCC(.halfcarry) == false)
    }

    @Test func test_irq_flag() {
        #expect(0b0000_0000 == cpu.CC)
        #expect(cpu.readCC(.irq) == false)

        cpu.setCC(.irq, true)
        #expect(0b0001_0000 == cpu.CC)
        #expect(cpu.readCC(.irq) == true)

        cpu.setCC(.irq, false)
        #expect(0b0000_0000 == cpu.CC)
        #expect(cpu.readCC(.irq) == false)
    }

    @Test func test_negative_flag() {
        #expect(0b0000_0000 == cpu.CC)
        #expect(cpu.readCC(.negative) == false)

        cpu.setCC(.negative, true)
        #expect(0b0000_1000 == cpu.CC)
        #expect(cpu.readCC(.negative) == true)

        cpu.setCC(.negative, false)
        #expect(0b0000_0000 == cpu.CC)
        #expect(cpu.readCC(.negative) == false)
    }

    @Test func test_zero_flag() {
        #expect(0b0000_0000 == cpu.CC)
        #expect(cpu.readCC(.zero) == false)

        cpu.setCC(.zero, true)
        #expect(0b0000_0100 == cpu.CC)
        #expect(cpu.readCC(.zero) == true)

        cpu.setCC(.zero, false)
        #expect(0b0000_0000 == cpu.CC)
        #expect(cpu.readCC(.zero) == false)
    }

    @Test func test_overflow_flag() {
        #expect(0b0000_0000 == cpu.CC)
        #expect(cpu.readCC(.overflow) == false)

        cpu.setCC(.overflow, true)
        #expect(0b0000_0010 == cpu.CC)
        #expect(cpu.readCC(.overflow) == true)

        cpu.setCC(.overflow, false)
        #expect(0b0000_0000 == cpu.CC)
        #expect(cpu.readCC(.overflow) == false)
    }

    @Test func test_carry_flag() {
        #expect(0b0000_0000 == cpu.CC)
        #expect(cpu.readCC(.carry) == false)

        cpu.setCC(.carry, true)
        #expect(0b0000_0001 == cpu.CC)
        #expect(cpu.readCC(.carry) == true)

        cpu.setCC(.carry, false)
        #expect(0b0000_0000 == cpu.CC)
        #expect(cpu.readCC(.carry) == false)
    }
}
