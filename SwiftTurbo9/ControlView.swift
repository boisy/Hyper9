//
//  ControlView.swift
//  SwiftTurbo9
//
//  Created by Boisy Pitre on 2/15/25.
//

import SwiftUI
import UniformTypeIdentifiers

struct ControlView: View {
    @EnvironmentObject var model: Turbo9ViewModel
    @State var gotoAddress : UInt16 = 0
    @State var stepCount : UInt16 = 1
    @State var goLabel = "play.fill"

    var body: some View {
        let cyclesPerTick : UInt = 1000
        let stepClosure :() -> Void = {
            if stepCount > 0 {
                model.updateCPU()
                let startTime = Date()
                
                for _ in 1...stepCount {
                    model.step()
                }
                model.instructionsPerSecond = Double(stepCount) / Date().timeIntervalSince(startTime)
                model.turbo9.checkDisassembly()
                model.updateUI()
            }
        }
        let runClosure : () -> Void = {
            if model.running == true {
                model.running = false
                goLabel = "play.fill"
                model.updateUI()
            } else {
                model.running = true
                goLabel = "pause.fill"
                model.updateCPU()
                DispatchQueue.global(qos: .background).async {
                    let startTime = Date()
                    var instructionCount = 0
                    repeat {
                        model.step()
                        instructionCount += 1
                        if model.timerRunning == true && model.turbo9.clockCycles % cyclesPerTick == 0 {
                            model.invokeTimer()
                        }
                        if model.timerRunning == true && model.turbo9.clockCycles % (cyclesPerTick * 50) == 0 {
                            DispatchQueue.main.sync {
                                //                                            model.turbo9.checkDisassembly()
                                //                                            model.updateUI()
                            }
                        }
                    } while model.running == true && model.turbo9.PC != UInt16(gotoAddress)
                    DispatchQueue.main.async {
                        model.instructionsPerSecond = Double(instructionCount) / Date().timeIntervalSince(startTime)
                        model.running = false
                        goLabel = "play.fill"
                        model.turbo9.checkDisassembly()
                        model.updateUI()
                    }
                }
            }
        }
        HStack {
            GroupBox {
                HStack {
                    Button(action: {
                        model.running = false
                        model.turbo9.assertIRQ()
                        model.turbo9.checkDisassembly()
                        model.updateUI()
                    }) {
                        Image(systemName: "i.circle")
                    }
                    
                    Button(action: {
                        model.running = false
                        model.turbo9.assertFIRQ()
                        model.turbo9.checkDisassembly()
                        model.updateUI()
                    }) {
                        Image(systemName: "f.circle")
                    }
                    
                    Button(action: {
                        model.running = false
                        model.turbo9.assertNMI()
                        model.turbo9.checkDisassembly()
                        model.updateUI()
                    }) {
                        Image(systemName: "n.circle")
                    }
                    
                    Button(action: {
                        model.running = false
                        model.invokeTimer()
                        model.turbo9.checkDisassembly()
                        model.updateUI()
                    }) {
                        Image(systemName: "timer")
                    }
                }
            } label: {
                Label("Interrupts", systemImage: "stop.fill")
            }

            GroupBox {
                HStack {
                    Button(action: {
                        if let operation = model.turbo9.disassemble() {
                            if operation.addressMode == .rel8 || operation.addressMode == .rel16 {
                                gotoAddress = model.turbo9.PC &+ UInt16(operation.size)
                                runClosure()
                            } else {
                                stepClosure()
                            }
                        }
                    }) {
                        Image(systemName: "arrow.right")
                    }
                    .disabled(model.running == true)
                    
                    Button(action: {
                        stepClosure()
                    }) {
                        Image(systemName: "arrow.down")
                    }
                    .disabled(model.running == true)
                    
                    Button(action: {
                    }) {
                        Image(systemName: "arrow.up")
                    }
                    .disabled(model.running == true)
                    
                    DecTextField(number: $stepCount)
                }
            } label: {
                Label("Step", systemImage: "figure.step.training")
            }

            GroupBox {
                HStack {
                    Button(action: runClosure
                    ) {
                        Image(systemName: goLabel)
                    }
                    
                    Hex16TextField(number: $gotoAddress)
                }
            } label: {
                Label("Run", systemImage: "figure.run")
            }

            GroupBox {
                HStack {
                    Button(action: {
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
                                model.turbo9.checkDisassembly()
                                model.updateUI()
                            } else {
                                // User canceled the selection
                            }
                        }
                        model.reset()
                    }) {
                        Image(systemName: "folder.badge.plus")
                    }
                    .disabled(model.running == true)
                    
                    Button(action: {
                        model.reset()
                        model.turbo9.checkDisassembly()
                        model.updateUI()
                    }) {
                        Image(systemName: "button.horizontal.top.press")
                    }
                    .disabled(model.running == true)
                    Toggle("log", systemImage: "text.alignleft", isOn: $model.logging)
                        .toggleStyle(.checkbox)
                }
            } label: {
                Label("Control", systemImage: "gamecontroller.fill")
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
}

#Preview {
    let model = Turbo9ViewModel()
    ControlView()
        .environmentObject(model)
}
