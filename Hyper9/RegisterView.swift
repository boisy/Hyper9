//
//  RegisterView.swift
//  Hyper9
//
//  Created by Boisy Pitre on 1/26/25.
//

import SwiftUI

struct RegisterView : View {
    @EnvironmentObject var model: Turbo9ViewModel

    let viewWidth = 116.0
    let fieldWidth = 100.0
    let labelWidth = 28.0
    var body: some View {
        GroupBox {
            HStack {
                VStack {
                    HStack {
                        LabeledHex8TextField(label: "A:", number: $model.A, update: {model.turbo9.A = model.A})
                            .frame(maxWidth: .infinity, alignment: .leading)
                        LabeledHex8TextField(label: "B:", number: $model.B, update: {model.turbo9.B = model.B})
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        LabeledHex8TextField(label: "DP:", number: $model.DP, update: {model.turbo9.DP = model.DP})
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                VStack {
                    LabeledHex16TextField(label: "X:", number: $model.X, update: {model.turbo9.X = model.X})
                        .frame(maxWidth: .infinity, alignment: .leading)
                    LabeledHex16TextField(label: "Y:", number: $model.Y, update: {model.turbo9.Y = model.Y})
                        .frame(maxWidth: .infinity, alignment: .leading)
                }

                VStack {
                    LabeledHex16TextField(label: "U:", number: $model.U, update: {model.turbo9.U = model.U})
                        .frame(maxWidth: .infinity, alignment: .leading)
                    LabeledHex16TextField(label: "S:", number: $model.S, update: {model.turbo9.S = model.S})
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                VStack {
                    LabeledHex16TextField(label: "PC:", number: $model.PC, update: {model.turbo9.PC = model.PC})
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        Text("CC:")
                            .frame(width: 28)
                        TextField(text: $model.ccString) {
                        }
                        .frame(width: 88)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .font(.system(.body, design: .monospaced))
                    }
                }
            }
//            .frame(width: viewWidth)
        } label: {
            Label("Registers", systemImage: "cpu")
        }
    }
}

#Preview {
    let model = Turbo9ViewModel()
    RegisterView()
        .environmentObject(model)
}
