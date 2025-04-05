import Foundation

/// The system bus extension that defines TurbOS interfaces.
public extension Turbo9CPU {
    private func readUInt8(from address: Int) -> UInt8 {
        return UInt8(bus.memory[address])
    }
    
    private func readUInt16(from address: Int) -> UInt16 {
        return UInt16(bus.memory[address]) << 8 | UInt16(bus.memory[address + 1])
    }
    
    private func writeUInt8(to address: Int, value: UInt8) {
        bus.write(UInt16(address), data: value)
    }
    
    private func writeUInt16(to address: Int, value: UInt16) {
        bus.write(UInt16(address), data: UInt8(value >> 8))   // High byte
        bus.write(UInt16(address + 1), data: UInt8(value & 0xFF))  // Low byte
    }
    
    var D_FMBM_Start : UInt16 {
        get { readUInt16(from: 0x20) }
        set { writeUInt16(to: 0x20, value: newValue) }
    }
    
    var D_FMBM_End : UInt16 {
        get { readUInt16(from: 0x22) }
        set { writeUInt16(to: 0x22, value: newValue) }
    }
    
    var D_MLIM : UInt16 {
        get { readUInt16(from: 0x24) }
        set { writeUInt16(to: 0x24, value: newValue) }
    }
    
    var D_ModDir_Start : UInt16 {
        get { readUInt16(from: 0x26) }
        set { writeUInt16(to: 0x26, value: newValue) }
    }
    
    var D_ModDir_End : UInt16 {
        get { readUInt16(from: 0x28) }
        set { writeUInt16(to: 0x28, value: newValue) }
    }
    
    var D_Init : UInt16 {
        get { readUInt16(from: 0x2A) }
        set { writeUInt16(to: 0x2A, value: newValue) }
    }
    
    var D_SWI3 : UInt16 {
        get { readUInt16(from: 0x2C) }
        set { writeUInt16(to: 0x2C, value: newValue) }
    }
    
    var D_SWI2 : UInt16 {
        get { readUInt16(from: 0x2E) }
        set { writeUInt16(to: 0x2E, value: newValue) }
    }
    
    var D_FIRQ : UInt16 {
        get { readUInt16(from: 0x30) }
        set { writeUInt16(to: 0x30, value: newValue) }
    }
    
    var D_IRQ : UInt16 {
        get { readUInt16(from: 0x32) }
        set { writeUInt16(to: 0x32, value: newValue) }
    }
    
    var D_SWI : UInt16 {
        get { readUInt16(from: 0x34) }
        set { writeUInt16(to: 0x34, value: newValue) }
    }
    
    var D_NMI : UInt16 {
        get { readUInt16(from: 0x36) }
        set { writeUInt16(to: 0x36, value: newValue) }
    }
    
    var D_SvcIRQ : UInt16 {
        get { readUInt16(from: 0x38) }
        set { writeUInt16(to: 0x38, value: newValue) }
    }
    
    var D_Poll : UInt16 {
        get { readUInt16(from: 0x3A) }
        set { writeUInt16(to: 0x3A, value: newValue) }
    }
    
    var D_UsrIRQ : UInt16 {
        get { readUInt16(from: 0x3C) }
        set { writeUInt16(to: 0x3C, value: newValue) }
    }
    
    var D_SysIRQ : UInt16 {
        get { readUInt16(from: 0x3E) }
        set { writeUInt16(to: 0x3E, value: newValue) }
    }
    
    var D_UsrSvc : UInt16 {
        get { readUInt16(from: 0x40) }
        set { writeUInt16(to: 0x40, value: newValue) }
    }
    
    var D_SysSvc : UInt16 {
        get { readUInt16(from: 0x42) }
        set { writeUInt16(to: 0x42, value: newValue) }
    }
    
    var D_UsrDis : UInt16 {
        get { readUInt16(from: 0x44) }
        set { writeUInt16(to: 0x44, value: newValue) }
    }
    
    var D_SysDis : UInt16 {
        get { readUInt16(from: 0x46) }
        set { writeUInt16(to: 0x46, value: newValue) }
    }
    
    var D_Slice : UInt8 {
        get { readUInt8(from: 0x48) }
        set { writeUInt8(to: 0x48, value: newValue) }
    }
    
    var D_PrcDBT : UInt16 {
        get { readUInt16(from: 0x49) }
        set { writeUInt16(to: 0x49, value: newValue) }
    }
    
    var D_Proc : UInt16 {
        get { readUInt16(from: 0x4B) }
        set { writeUInt16(to: 0x4B, value: newValue) }
    }
    
    var D_AProcQ : UInt16 {
        get { readUInt16(from: 0x4D) }
        set { writeUInt16(to: 0x4D, value: newValue) }
    }
    
    var D_WProcQ : UInt16 {
        get { readUInt16(from: 0x4F) }
        set { writeUInt16(to: 0x4F, value: newValue) }
    }
    
    var D_SProcQ : UInt16 {
        get { readUInt16(from: 0x51) }
        set { writeUInt16(to: 0x51, value: newValue) }
    }
    
    var D_Year : UInt8 {
        get { readUInt8(from: 0x53) }
        set { writeUInt8(to: 0x53, value: newValue) }
    }
    
    var D_Month : UInt8 {
        get { readUInt8(from: 0x54) }
        set { writeUInt8(to: 0x54, value: newValue) }
    }
    
    var D_Day : UInt8 {
        get { readUInt8(from: 0x55) }
        set { writeUInt8(to: 0x55, value: newValue) }
    }
    
    var D_Hour : UInt8 {
        get { readUInt8(from: 0x56) }
        set { writeUInt8(to: 0x56, value: newValue) }
    }
    
    var D_Min : UInt8 {
        get { readUInt8(from: 0x57) }
        set { writeUInt8(to: 0x57, value: newValue) }
    }
    
    var D_Sec : UInt8 {
        get { readUInt8(from: 0x58) }
        set { writeUInt8(to: 0x58, value: newValue) }
    }
    
    var D_Ticks_High : UInt16 {
        get { readUInt16(from: 0x59) }
        set { writeUInt16(to: 0x59, value: newValue) }
    }
    
    var D_Ticks_Low : UInt16 {
        get { readUInt16(from: 0x5B) }
        set { writeUInt16(to: 0x5B, value: newValue) }
    }
    
    var D_Tick : UInt8 {
        get { readUInt8(from: 0x5D) }
        set { writeUInt8(to: 0x5D, value: newValue) }
    }
    
    var D_TSec : UInt8 {
        get { readUInt8(from: 0x5E) }
        set { writeUInt8(to: 0x5E, value: newValue) }
    }
    
    var D_TSlice : UInt8 {
        get { readUInt8(from: 0x5F) }
        set { writeUInt8(to: 0x5F, value: newValue) }
    }
    
    var D_IOML : UInt16 {
        get { readUInt16(from: 0x60) }
        set { writeUInt16(to: 0x60, value: newValue) }
    }
    
    var D_IOMH : UInt16 {
        get { readUInt16(from: 0x62) }
        set { writeUInt16(to: 0x62, value: newValue) }
    }
    
    var D_DevTbl : UInt16 {
        get { readUInt16(from: 0x64) }
        set { writeUInt16(to: 0x64, value: newValue) }
    }
    
    var D_PolTbl : UInt16 {
        get { readUInt16(from: 0x66) }
        set { writeUInt16(to: 0x66, value: newValue) }
    }
    
    var D_PthDBT : UInt16 {
        get { readUInt16(from: 0x68) }
        set { writeUInt16(to: 0x68, value: newValue) }
    }
    
    var D_BTLO : UInt16 {
        get { readUInt16(from: 0x6A) }
        set { writeUInt16(to: 0x6A, value: newValue) }
    }
    
    var D_BTHI : UInt16 {
        get { readUInt16(from: 0x6C) }
        set { writeUInt16(to: 0x6C, value: newValue) }
    }
    
    var D_Clock : UInt16 {
        get { readUInt16(from: 0x6E) }
        set { writeUInt16(to: 0x6E, value: newValue) }
    }
    
    var D_Boot : UInt8 {
        get { readUInt8(from: 0x70) }
        set { writeUInt8(to: 0x70, value: newValue) }
    }
    
    var D_UrToSs : UInt16 {
        get { readUInt16(from: 0x71) }
        set { writeUInt16(to: 0x71, value: newValue) }
    }
    
    var D_VIRQTable : UInt16 {
        get { readUInt16(from: 0x73) }
        set { writeUInt16(to: 0x73, value: newValue) }
    }
    
    var D_CRC : UInt8 {
        get { readUInt8(from: 0x75) }
        set { writeUInt8(to: 0x75, value: newValue) }
    }
}
