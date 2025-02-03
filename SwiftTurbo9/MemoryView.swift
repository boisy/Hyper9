import SwiftUI

struct MemoryView: View {
    @EnvironmentObject var model: Turbo9ViewModel

    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                VStack(alignment: .leading) {
                        Text(model.memoryDump)
                            .font(.body)
                    }
                .monospaced()
                .padding()
            }
        }
    }
}


