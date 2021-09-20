//
//  macOS.swift
//  EmojiArt
//
//  Created by Anvar Rahimov on 19.09.2021.
//

import SwiftUI

typealias UIImage = NSImage

typealias PaletteManager = EmptyView

extension Image {
    init(uiImage: UIImage) {
        self.init(nsImage: uiImage)
    }
}

extension UIImage {
    var imageData: Data? { tiffRepresentation }
}

struct Pasteboard {
    static var imageData: Data? {
        NSPasteboard.general.data(forType: .tiff) ?? NSPasteboard.general.data(forType: .png)
    }
    static var imageURL: URL? {
        (NSURL(from: NSPasteboard.general) as URL?)?.imageURL
    }
}

extension View {
    func wrappedInNavigationViewToMakeDismissable(_ dismiss: (() -> Void)?) -> some View  {
        self
    }
    
    func paletteControlButtonStyle() -> some View {
        self.buttonStyle(PlainButtonStyle()).foregroundColor(.accentColor ).padding(.vertical)
    }
    
    func popoverPadding() -> some View {
        self.padding(.horizontal)
    }
}

struct CantDoItPhotoPicker: View {
    var handlePickedImage: (UIImage?) -> Void
    
    static let isAvailable = false
    
    var body: some View {
        EmptyView()
    }
}

typealias Camera = CantDoItPhotoPicker
typealias PhotoLibrary = CantDoItPhotoPicker
