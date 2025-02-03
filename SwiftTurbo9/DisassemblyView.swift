import SwiftUI

struct DisassemblyView: View {
    @EnvironmentObject var model : Turbo9ViewModel
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(model.operations.indices, id: \.self) { index in
                        HStack {
                            let showCurrentInstruction = (model.PC == model.operations[index].offset) && model.running == false
                            Text((showCurrentInstruction ? " -> " : "    ") + model.operations[index].asCode)
                                .monospaced()
                                .font(Font.system(size:12, design: .default))
                                .foregroundColor(showCurrentInstruction ? .blue : .primary) // Highlight active line
                                .background(showCurrentInstruction ? .yellow : .clear) // Highlight active line
                            //                        .animation(.easeInOut, value: highlightedLineIndex)
                        }
                    }
                }
            }
        }
    }
}


