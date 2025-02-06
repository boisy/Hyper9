//
//  DocumentView.swift
//  SwiftTurbo9
//
//  Created by Boisy Pitre on 1/22/25.
//

import SwiftUI
import Turbo9Sim
import UniformTypeIdentifiers

struct DocumentView: View {
    // Bind to the document so changes are automatically saved.
    @Binding var document: SimDocument
    @EnvironmentObject var model: Turbo9ViewModel

    var body: some View {
        HStack {
            VStack {
                MemoryView()
                TerminalView()
            }
            .frame(width:640, height: 640)

            VStack {
                ZStack {
                    if model.running == true {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                            .scaleEffect(1.5) // Optional: makes the spinner larger
                            .padding()
                    }
                    DisassemblyView()
                }
                RegisterView()
                ControlView()
                StatisticsView()
            }
            .frame(width:640, height: 640)
            .padding()
            .task {
                let _ = model.disassemble(instructionCount: 2)
                model.updateUI()
            }
        }
        .onAppear() {
        }
        .onReceive(model.$PC) { newValue in
            model.turbo9.checkDisassembly()
        }
    }
}


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
    public var turbo9 = Disassembler(program: [UInt8].init(repeating: 0x00, count: 65536), logPath: "/Users/boisy/turbo9.log")
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
        } catch {
            
        }
    }

    func load(url: URL) {
        do {
            try turbo9.load(url: url)
            outputString = ""
            updateUI()
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
        let outputHandler = BusHandler(address: 0xFF00, handler: { value in
            self.outputBuffer += String(format: "%c", value)
            DispatchQueue.main.async {
                self.updateUI()
            }
        })
        turbo9.bus.addHandler(handler: outputHandler)
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
            
            Button("Load") {
                let openPanel = NSOpenPanel()
                openPanel.title = "Choose an image file"
                openPanel.showsHiddenFiles = false
                openPanel.canChooseDirectories = false
                openPanel.canChooseFiles = true
                openPanel.allowsMultipleSelection = false
                openPanel.allowedContentTypes = [UTType(filenameExtension: "img")!]

                openPanel.begin { (result) in
                    if result == .OK, let url = openPanel.url {
                        // Use the selected file URL
                        model.load(url: url)
                    } else {
                        // User canceled the selection
                    }
                }
                model.reset()
            }
            .disabled(go == true)

            Button("Reset") {
                model.reset()
                model.updateUI()
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
