//
//  ContentView.swift
//  SwiftTurbo9
//
//  Created by Boisy Pitre on 1/22/25.
//

import SwiftUI

struct ContentView: View {
    @State var niceDisassembly : String = ""
    @EnvironmentObject var disassembler: Disassembler
    @State var gotoAddress : UInt16 = 0

    var body: some View {
        HStack {
            VStack {
                MemoryView()
                TerminalView()
            }
            VStack {
                ScrollView {
                    HStack {
                        RegisterView()
                        DisassemblyView()
                    }
                }
                HStack {
                    Button("Step") {
                        do {
                            try disassembler.step()
                        } catch {
                            
                        }
                    }
                    Button("Step x10") {
                        do {
                            try disassembler.step(count: 10)
                        } catch {
                            
                        }
                    }
                    Button("Step x100") {
                        do {
                            try disassembler.step(count: 100)
                        } catch {
                            
                        }
                    }
                    HStack {
                        Hex16TextField(label: "Go to:", number: $gotoAddress)

                        Button("Go") {
                            do {
                                try disassembler.continueExection(to: gotoAddress)
                            } catch {
                                
                            }
                        }
                    }
                    Button("Reload") {
                        do {
                            try reload()
                            try disassembler.reset()
                        } catch {
                            
                        }
                    }
                }
            }
            .padding()
            .task {
                let _ = disassembler.disassemble(instructionCount: 2)
            }
        }
        .onAppear() {
            do {
                try reload()
            } catch {
                
            }
        }
    }
    
    func reload() throws {
        do {
            try disassembler.reload(filePath: "/Users/boisy/Projects/turbos/ports/turbo9sim/turbos_image")
        }
    }
}


 #Preview {
    ContentView()
         .environmentObject(Disassembler())
}
