//
//  TerminalView.swift
//  SwiftTurbo9
//
//  Created by Boisy Pitre on 2/1/25.
//

import SwiftUI

struct TerminalView: View {
    @EnvironmentObject var model: Turbo9ViewModel
    @State private var accumulatedString: String = "" // The accumulated string
    
    private let charWidth: CGFloat = 7    // estimated width of one character
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
                     alignment: .leading
                 )
                 .border(Color.gray)
                 .background(Color.black.opacity(0.05))
            }
        }
        .onReceive(model.$outputString) { newValue in
            accumulatedString = newValue
        }
    }
}
    
#Preview {
    TerminalView()
}
