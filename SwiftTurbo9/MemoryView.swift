import SwiftUI

struct MemoryView: View {
    @EnvironmentObject var disassembler : Disassembler
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading) {
                        Text(disassembler.memoryDump)
                            .font(.body)
                    }
                .monospaced()
                .padding()
            }
        }
    }
}


