//
//  TerminalView.swift
//  Hyper9
//
//  Created by Boisy Pitre on 2/1/25.
//

import SwiftUI

struct ModuleDirectoryView: View {
    @EnvironmentObject var model: Turbo9ViewModel
    
    private let charWidth: CGFloat = 7    // estimated width of one character
    private let lineHeight: CGFloat = 12   // estimated height of one line

    func moduleInfo(address: UInt16) -> String {
        var result = String(format: "%04X: ", address)
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

        return result + "\n"
    }

    func directory() -> String {
        var result = ""
        for a in stride(from: 0x300, to: 0x400, by: 4) {
            let modulePointer = model.turbo9.readWord(UInt16(a))
            if modulePointer != 0x00 {
                result = result + " " + moduleInfo(address: modulePointer)
            }
        }
        return result
    }
    
    var body: some View {
        GroupBox {
            ScrollViewReader { proxy in
                ScrollView {
                    VStack(alignment: .leading) {
                        Text(directory())
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
            Label("Module Directory", systemImage: "apple.terminal")
        }
    }
}
    
#Preview {
    let model = Turbo9ViewModel()
    TerminalView()
        .environmentObject(model)
}
