import SwiftUI

extension String {
    /// Returns a new string padded with spaces to the specified total length.
    func padded(toLength length: Int) -> String {
        let padCount = length - self.count
        guard padCount > 0 else { return self } // No padding needed if already at or over the desired length
        return self + String(repeating: " ", count: padCount)
    }
}

struct DisassemblyView: View {
    @EnvironmentObject var model : Turbo9ViewModel
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(model.operations.indices, id: \.self) { index in
                        HStack {
                            let showCurrentInstruction = (model.PC == model.operations[index].offset) && model.running == false
                            Text(((showCurrentInstruction ? " -> " : "    ") + model.operations[index].asCode).padded(toLength: 70))
                                .monospaced()
                                .font(Font.system(size:16, design: .default))
                                .foregroundColor(showCurrentInstruction ? .blue : .primary) // Highlight active line
                                .background(showCurrentInstruction ? .yellow : .clear) // Highlight active line
                            //                        .animation(.easeInOut, value: highlightedLineIndex)
                        }
                    }
                }
            }
            .frame(width: 640, height: 540)
        }
    }
}


