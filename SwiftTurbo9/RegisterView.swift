//
//  RegisterView.swift
//  SwiftTurbo9
//
//  Created by Boisy Pitre on 1/26/25.
//

import SwiftUI

struct RegisterView : View {
    @EnvironmentObject var disassembler : Disassembler
    let labelWidth = 28.0
    var body: some View {
        VStack {
            Hex8TextField(label: "A:", number: $disassembler.A)
            Hex8TextField(label: "B:", number: $disassembler.B)
            Hex8TextField(label: "DP:", number: $disassembler.DP)
            Hex16TextField(label: "X:", number: $disassembler.X)
            Hex16TextField(label: "Y:", number: $disassembler.Y)
            Hex16TextField(label: "U:", number: $disassembler.U)
            Hex16TextField(label: "S:", number: $disassembler.S)
            Hex16TextField(label: "PC:", number: $disassembler.PC)
            HStack {
                Text("CC:")
                    .frame(width: labelWidth)
                TextField(text: $disassembler.ccString) {
                    
                }.monospaced()
            }
        }
        .frame(width: 120)
    }
}

