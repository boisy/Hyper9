import SwiftUI

struct DisassemblyView: View {
    @EnvironmentObject var disassembler : Disassembler
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(disassembler.operations.indices, id: \.self) { index in
                        Text(disassembler.operations[index].asCode)
                            .font(.body)
                            .foregroundColor(disassembler.PC == disassembler.operations[index].offset ? .blue : .primary) // Highlight active line
                        //                        .animation(.easeInOut, value: highlightedLineIndex)
                    }
                    .monospaced()
                }
                .padding()
            }
        }
    }
}


