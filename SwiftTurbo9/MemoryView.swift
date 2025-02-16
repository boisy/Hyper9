import SwiftUI

struct MemoryView: View {
    @EnvironmentObject var model: Turbo9ViewModel

    var body: some View {
        GroupBox {
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
        } label: {
            Label("Memory", systemImage: "memorychip")
        }
    }
}

#Preview {
    let model = Turbo9ViewModel()
    MemoryView()
        .environmentObject(model)
}
