//
//  BreakpointView.swift
//  Hyper9
//
//  Created by Boisy Pitre on 2/15/25.
//

import SwiftUI

struct BreakpointView: View {
    @Binding var breakpoints: [String]
    @State private var newBreakpoint: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter new breakpoint", text: $newBreakpoint)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(maxWidth: .infinity)
                Button(action: addBreakpoint) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                }
                .disabled(newBreakpoint.isEmpty)
            }
            .padding()
            
            List {
                ForEach(breakpoints.indices, id: \.self) { index in
                    HStack {
                        Text(breakpoints[index])
                        Spacer()
                        Button(action: {
                            removeBreakpoint(at: index)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                        .buttonStyle(BorderlessButtonStyle())
                    }
                }
            }
        }
    }
    
    private func addBreakpoint() {
        breakpoints.append(newBreakpoint)
        newBreakpoint = ""
    }
    
    private func removeBreakpoint(at index: Int) {
        breakpoints.remove(at: index)
    }
}


#Preview {
    @Previewable @State var b : [String] = []
    let model = Turbo9ViewModel()
    BreakpointView(breakpoints: $b)
        .environmentObject(model)
}
