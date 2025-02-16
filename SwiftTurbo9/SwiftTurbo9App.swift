//
//  SwiftTurbo9App.swift
//  SwiftTurbo9
//
//  Created by Boisy Pitre on 1/22/25.
//

import SwiftUI
import UniformTypeIdentifiers

@main
struct SwiftTurbo9App: App {
    var body: some Scene {
        DocumentGroup(newDocument: SimDocument()) { file in
            // Pass the document binding to your view.
            DocumentView(document: file.$document)
                .environmentObject(file.document.disassembler)
        }
    }
}


