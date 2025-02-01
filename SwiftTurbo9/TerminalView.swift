//
//  TerminalView.swift
//  SwiftTurbo9
//
//  Created by Boisy Pitre on 2/1/25.
//

import SwiftUI

struct TerminalView: View {
    @EnvironmentObject var disassembler : Disassembler
    @State private var accumulatedString: String = "" // The accumulated string
    
    private let charWidth: CGFloat = 6    // estimated width of one character
    private let lineHeight: CGFloat = 12   // estimated height of one line

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading) {
                    Text("\(accumulatedString)")
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
                 .background(Color.black.opacity(0.05))
                 .padding()
            }
        }
        // Listen for changes in outputChar.
        .onReceive(disassembler.bus.$outputTerminalCharacter) { newValue in
            if newValue >= 0x20 && newValue <= 0x7F {
                // Convert UInt8 to Character using UnicodeScalar.
                let scalar = UnicodeScalar(newValue)
                let char = Character(scalar)
                // Append the character to our display string.
                accumulatedString.append(char)
            }
        }
    }
}
    
#Preview {
    TerminalView()
}
