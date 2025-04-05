//
//  ProcessView.swift
//  Hyper9
//
//  Created by Boisy Pitre on 2/1/25.
//

import SwiftUI

struct ProcessView: View {
    @EnvironmentObject var model: Turbo9ViewModel
    
    private let charWidth: CGFloat = 7    // estimated width of one character
    private let lineHeight: CGFloat = 12   // estimated height of one line

    func moduleName(address: UInt16) -> String {
        var result = ""
        let syncBytes = model.turbo9.readWord(address)
        if syncBytes == 0x87CD {
            let nameOffset = model.turbo9.readWord(address + 4)
            var nameAddress = nameOffset + address
            var nameChar : UInt8 = 0
            repeat {
                nameChar = model.turbo9.readByte(nameAddress)
                if nameChar & 0x80 == 0 {
                    let scalar = UnicodeScalar(nameChar)
                    let character = Character(scalar)
                    result.append(character)
                } else {
                    let scalar = UnicodeScalar(nameChar & 0x7F)
                    let character = Character(scalar)
                    result.append(character)
                }
                nameAddress = nameAddress + 1
            } while nameChar & 0x80 == 0x00
        } else {
            result = "Invalid Sync"
        }

        return result
    }

    func processInfo(address: UInt16) -> String {
        var result = ""
        let processID = model.turbo9.readByte(address)
        if processID != 0x00 {
            // there a valid process here
            result = "\(processID) - \(moduleName(address: model.turbo9.readWord(address + 0x12)))\n"
        }
        return result
    }
    
    func procs() -> String {
        var result = ""
        let pageTableAddress = 0xE800
        for pageAddress in pageTableAddress..<pageTableAddress+0x40 {
            let pageUpper = model.turbo9.readByte(UInt16(pageAddress))
            if pageUpper != 0x00 {
                var pageAddress = UInt16(pageUpper) * 256
                if pageAddress == pageTableAddress {
                        pageAddress += 0x40
                }
                for a in stride(from: pageAddress, to: pageAddress+(0x40*4), by: 0x40) {
                        result = result + processInfo(address: UInt16(a))
                }
            }
        }
        return result
    }
    
    var body: some View {
        GroupBox {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading) {
                        Text(procs())
                            .padding()
                            .monospaced()
                    }
                    .font(.system(size: 14, design: .monospaced))
                    .frame(
                        width: CGFloat(80) * charWidth,
                        height: CGFloat(24) * lineHeight,
                        alignment: .topLeading
                    )
                    .border(Color.gray)
                    .background(Color.black.opacity(0.95))
                    .foregroundColor(Color.white)
                }
            }
        } label: {
            Label("Processes", systemImage: "apple.terminal")
        }
    }
}
    
#Preview {
    let model = Turbo9ViewModel()
    ProcessView()
        .environmentObject(model)
}
