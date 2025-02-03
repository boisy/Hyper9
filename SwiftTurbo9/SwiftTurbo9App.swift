//
//  SwiftTurbo9App.swift
//  SwiftTurbo9
//
//  Created by Boisy Pitre on 1/22/25.
//

import SwiftUI

@main
struct SwiftTurbo9App: App {
    @StateObject private var disassembler = Turbo9ViewModel()
    //Disassembler(filePath: "/Users/boisy/Projects/turbos/ports/turbo9sim/turbos_image", pc: 0xf014)

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(disassembler)
        }
    }
}
