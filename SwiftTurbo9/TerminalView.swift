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
        GroupBox {
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
                    .background(Color.black.opacity(0.95))
                    .foregroundColor(Color.white)
                }
            }
            .onReceive(model.$outputString) { newValue in
                accumulatedString = newValue
            }
        } label: {
            Label("Terminal", systemImage: "apple.terminal")
        }
    }
}
    
#Preview {
    let model = Turbo9ViewModel()
    TerminalView()
        .environmentObject(model)
}
