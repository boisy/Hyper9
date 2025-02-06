//
//  RegisterView.swift
//  SwiftTurbo9
//
//  Created by Boisy Pitre on 1/26/25.
//

import SwiftUI

struct RegisterView : View {
    @EnvironmentObject var model: Turbo9ViewModel

    let labelWidth = 28.0
    var body: some View {
        HStack {
            Hex8TextField(label: "A:", number: $model.A, update: {model.turbo9.A = model.A})
            Hex8TextField(label: "B:", number: $model.B, update: {model.turbo9.B = model.B})
            Hex16TextField(label: "X:", number: $model.X, update: {model.turbo9.X = model.X})
            Hex16TextField(label: "Y:", number: $model.Y, update: {model.turbo9.Y = model.Y})
            Hex16TextField(label: "U:", number: $model.U, update: {model.turbo9.U = model.U})
        }
        .frame(width: 540)
        HStack {
            Hex8TextField(label: "DP:", number: $model.DP, update: {model.turbo9.DP = model.DP})
            Hex16TextField(label: "S:", number: $model.S, update: {model.turbo9.S = model.S})
            Hex16TextField(label: "PC:", number: $model.PC, update: {model.turbo9.PC = model.PC})
            Text("CC:")
                .frame(width: labelWidth)
            TextField(text: $model.ccString) {
            }
        }
        .frame(width: 540)
    }
}

