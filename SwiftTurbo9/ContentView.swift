//
//  ContentView.swift
//  SwiftTurbo9
//
//  Created by Boisy Pitre on 1/22/25.
//

import SwiftUI

struct StatisticsView: View {
    @EnvironmentObject var disassembler: Disassembler
    
    var body: some View {
        HStack {
            Text("Instruction count:")
            TextField("",  value: $disassembler.instructionsExecuted, format: .number)
                .disabled(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct ControlView: View {
    @EnvironmentObject var disassembler: Disassembler
    @State var gotoAddress : UInt16 = 0

    var body: some View {
        HStack {
            Button("IRQ") {
                if disassembler.readCC(.firq) == false {
                    disassembler.assertIRQ()
                }
            }
            Button("FIRQ") {
                if disassembler.readCC(.firq) == false {
                    disassembler.assertFIRQ()
                }
            }
            Button("NMI") {
                disassembler.assertNMI()
            }
            Button("TimerIRQ") {
                if disassembler.readCC(.irq) == false {
                    disassembler.bus.invokeTimer()
                }
            }
            Button("Step") {
                do {
                    try disassembler.step()
                } catch {
                    
                }
            }
            .disabled(disassembler.syncToInterrupt == true)
            Button("Step x10") {
                do {
                    for _ in 1...10 {
                        try disassembler.step()
                    }
                } catch {
                    
                }
            }
            .disabled(disassembler.syncToInterrupt == true)
            Button("Step x100") {
                do {
                    for _ in 1...100 {
                        try disassembler.step()
                    }
                } catch {
                    
                }
            }
            .disabled(disassembler.syncToInterrupt == true)
            HStack {
                Hex16TextField(label: "Go to:", number: $gotoAddress)
                
                Button("Go") {
                    do {
                        while disassembler.PC != UInt16(gotoAddress) && disassembler.syncToInterrupt == false {
                            for _ in 1..<1000 {
                                try disassembler.step()
                            }
                        }
                    } catch {
                        
                    }
                }
            }
            .disabled(disassembler.syncToInterrupt == true)
            Button("Reload") {
                do {
                    try reload()
                    try disassembler.reset()
                } catch {
                    
                }
            }
        }
    }
    
    func reload() throws {
        do {
            try disassembler.reload(filePath: "/Users/boisy/Projects/turbos/ports/turbo9sim/turbos_image")
        }
    }
}

struct ContentView: View {
    @State var niceDisassembly : String = ""
    @EnvironmentObject var disassembler: Disassembler

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
                StatisticsView()
                ControlView()
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
        .onReceive(disassembler.$PC) { newValue in
            disassembler.checkDisassembly()
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
