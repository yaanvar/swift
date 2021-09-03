//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by Anvar Rahimov on 03.09.2021.
//

import SwiftUI

@main
struct EmojiArtApp: App {
    let document = EmojiArtDocument()
    
    var body: some Scene {
        WindowGroup {
            EmojiArtDocumentView(document: document)
        }
    }
}
