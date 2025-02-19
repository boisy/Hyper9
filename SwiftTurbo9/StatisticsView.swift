//
//  StatisticsView.swift
//  SwiftTurbo9
//
//  Created by Boisy Pitre on 2/15/25.
//

import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject var model: Turbo9ViewModel

    var body: some View {
        GroupBox {
            HStack {
                Text("Instructions:")
                TextField("",  value: $model.turbo9.instructionsExecuted, format: .number)
                    .disabled(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 90)
                Text("Interrupts:")
                TextField("",  value: $model.turbo9.interruptsReceived, format: .number)
                    .disabled(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 90)
                Text("Clock Cycles:")
                TextField("",  value: $model.turbo9.clockCycles, format: .number)
                    .disabled(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 90)
                Text("IPS:")
                TextField("",  value: $model.turbo9.secondsPerInstruction, format: .number)
                    .disabled(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 90)
            }
        } label: {
            Label("Statistics", systemImage: "chart.bar.fill")
        }
        .frame(width:620)
    }
}

#Preview {
    let model = Turbo9ViewModel()
    StatisticsView()
        .environmentObject(model)
}
