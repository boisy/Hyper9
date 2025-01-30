//
//  SwiftTurbo9App.swift
//  SwiftTurbo9
//
//  Created by Boisy Pitre on 1/22/25.
//

import SwiftUI

@main
struct SwiftTurbo9App: App {
    @StateObject private var disassembler = Disassembler(filePath: "/Users/boisy/Projects/turbos/ports/turbo9sim/turbos_image", pc: 0xf314)
//    @StateObject private var disassembler = Disassembler(filePath: "/Users/boisy/Projects/apple/SwiftTurbo9Recipes/SwiftTurbo9/asmtests/lda", pc: 0x100)

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(disassembler)
        }
    }
}
