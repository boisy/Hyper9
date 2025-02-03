//
//  ContentView.swift
//  SwiftTurbo9
//
//  Created by Boisy Pitre on 1/22/25.
//

import SwiftUI
import Turbo9Sim

class Turbo9ViewModel: ObservableObject {
    @Published var A: UInt8 = 0x00
    @Published var B: UInt8 = 0x00
    @Published var DP: UInt8 = 0x00
    @Published var X: UInt16 = 0x0000
    @Published var Y: UInt16 = 0x0000
    @Published var U: UInt16 = 0x0000
    @Published var S: UInt16 = 0x0000
    @Published var PC: UInt16 = 0x0000
    @Published var ccString: String = ""
    @Published var instructionsExecuted: UInt = 0
    @Published var operations: [Disassembler.Turbo9Operation] = []
    @Published var memoryDump: String = ""
    public var turbo9 = Disassembler()
    public var updateUI: (() -> Void) = {}
    public var output : UInt8 = 0
    @Published public var outputString = ""
    private var outputBuffer = ""
    @Published var running = false
    
    func disassemble(instructionCount: UInt) {
        let _ = turbo9.disassemble(instructionCount: instructionCount)
        updateUI()
    }
    
    func step() {
        do {
            try turbo9.step()
            if self.turbo9.bus.outputTerminalCharacter != 0x00 {
                self.outputBuffer += String(format: "%c", (self.turbo9.bus.outputTerminalCharacter))
                self.turbo9.bus.outputTerminalCharacter = 0x00
                DispatchQueue.main.async {
                    self.updateUI()
                }
            }
        } catch {
            
        }
    }

    func reload() {
        do {
            try turbo9.reset()
            outputString = ""
            updateUI()
        } catch {
            
        }
    }

    func reload(filePath: String) {
        do {
            try turbo9.reload(filePath: filePath)
        } catch {
            
        }
    }

    func reset() {
        do {
            try turbo9.reset()
        } catch {
            
        }
    }

    init() {
        // Set the model’s update callback to update the published property.
        updateUI = { [weak self] in
            // Make sure to update on the main thread.
            DispatchQueue.main.async {
                if let self = self {
                    self.A = self.turbo9.A
                    self.B = self.turbo9.B
                    self.DP = self.turbo9.DP
                    self.X = self.turbo9.X
                    self.Y = self.turbo9.Y
                    self.U = self.turbo9.U
                    self.S = self.turbo9.S
                    self.ccString = self.turbo9.ccString
                    self.PC = self.turbo9.PC
                    self.instructionsExecuted = self.turbo9.instructionsExecuted
                    self.memoryDump = self.turbo9.memoryDump
                    self.operations = self.turbo9.operations
                    self.outputString = self.outputBuffer
                }
            }
        }
    }

    func startTask() {
        do {
            try turbo9.step()
            updateUI()
        } catch {
            
        }
    }
}

struct StatisticsView: View {
    @EnvironmentObject var model: Turbo9ViewModel

    var body: some View {
        HStack {
            Text("Instruction count:")
            TextField("",  value: $model.instructionsExecuted, format: .number)
                .disabled(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
}

struct ControlView: View {
    @EnvironmentObject var model: Turbo9ViewModel
    @State var gotoAddress : UInt16 = 0
    @State var stepCount : UInt16 = 1
    @State var go = false
    @State var goLabel = "Go"

    var body: some View {
        HStack {
            Button("IRQ") {
                model.turbo9.assertIRQ()
                model.updateUI()
            }

            Button("FIRQ") {
                model.turbo9.assertFIRQ()
                model.updateUI()
            }

            Button("NMI") {
                model.turbo9.assertNMI()
                model.updateUI()
            }

            Button("TimerIRQ") {
                model.turbo9.bus.invokeTimer()
                model.updateUI()
            }

            Button("Step") {
                if stepCount > 0 {
                    for _ in 1...stepCount {
                        model.step()
                    }
                    model.updateUI()
                }
            }
            .disabled(go == true)
            DecTextField(label: "Count:", number: $stepCount)

            HStack {
                Hex16TextField(label: "Go to:", number: $gotoAddress)
                
                Button(goLabel) {
                    if go == true {
                        go = false
                        goLabel = "Go"
                        model.updateUI()
                    } else {
                        go = true
                        goLabel = "Stop"
                    }
                    model.running = true
                    DispatchQueue.global(qos: .userInitiated).async {
                        while go == true && model.turbo9.PC != UInt16(gotoAddress) {
                            model.step()
                        }

                        DispatchQueue.main.async {
                            model.running = false
                            go = false
                            goLabel = "Go"
                            model.updateUI()
                        }
                    }
                }

            }
            
            Button("Reload") {
                    model.reload()
                    model.reset()
            }
            .disabled(go == true)
        }
/*
 .onChange(of: model.PC) { newValue in
                    print("Text changed to: \(newValue)")
            model.turbo9.PC = newValue
                    // Perform any additional actions when the text changes.
                }
 */
    }
}

struct ContentView: View {
    @State var niceDisassembly : String = ""
    @EnvironmentObject var model: Turbo9ViewModel

    var body: some View {
        HStack {
            VStack {
                MemoryView()
                TerminalView()
            }
            VStack {
                HStack {
                    RegisterView()
                    ScrollView {
                        DisassemblyView()
                    }
                }
                    if model.running == true {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1.5) // Optional: makes the spinner larger
                            .padding()
                    }
                ControlView()
                StatisticsView()
            }
            .padding()
            .task {
                let _ = model.disassemble(instructionCount: 2)
                model.updateUI()
            }
        }
        .onAppear() {
            do {
                try reload()
            } catch {
                
            }
        }
        .onReceive(model.$PC) { newValue in
            model.turbo9.checkDisassembly()
        }
    }
    
    func reload() throws {
        do {
            model.reload(filePath: "/Users/boisy/Projects/turbos/ports/turbo9sim/turbos_uio.img")
        }
    }
}


 #Preview {
    ContentView()
}
