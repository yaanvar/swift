//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by CS193p Instructor on 4/26/21.
//  Copyright © 2021 Stanford University. All rights reserved.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    @ObservedObject var document: EmojiArtDocument
    
    let defaultEmojiFontSize: CGFloat = 40
    
    var body: some View {
        VStack(spacing: 0) {
            documentBody
            palette
        }
    }
    
    var documentBody: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white.overlay(
                    OptionalImage(uiImage: document.backgroundImage)
                        .scaleEffect(zoomScale)
                        .position(convertFromEmojiCoordinates((0,0), in: geometry))
                )
                .gesture(doubleTapToZoom(in: geometry.size).exclusively(before: tapToDeselect()))
                if document.backgroundImageFetchStatus == .fetching {
                    ProgressView().scaleEffect(2)
                } else {
                    ForEach(document.emojis) { emoji in
                        Text(emoji.text)
                            .font(.system(size: fontSize(for: emoji)))
                            .scaleEffect(isSelected(emoji) ? zoomScale * gestureEmojiZoomScale : zoomScale)
                            .scaleEffect(isSelected(emoji) ? gestureZoomScale : 1)
                            .position(position(for: emoji, in: geometry))
                            .offset(isSelected(emoji) ? dragEmojiOffset * zoomScale : .zero)
                            .overlay(selectedEmojis.contains(where: { $0.id == emoji.id } ) ?
                                        (Image(systemName: "minus.circle")
                                            .font(.system(size: (fontSize(for: emoji) * zoomScale * gestureEmojiZoomScale) / 3 ))
                                            .position(position(for: emoji, in: geometry))
                                            .offset(x: 0.5 * fontSize(for: emoji) * zoomScale * gestureEmojiZoomScale + dragEmojiOffset.width * zoomScale * gestureEmojiZoomScale, y: -0.5 * fontSize(for: emoji) * zoomScale * gestureEmojiZoomScale + dragEmojiOffset.height * zoomScale * gestureEmojiZoomScale)) : nil)
                            .gesture(select(emoji))
                            .gesture(isSelected(emoji) ? dragEmojiGesture(for: emoji) : nil)
                    }
                }
            }
            .overlay(selectedEmojis.isEmpty ? nil :
                        VStack {
                            HStack {
                                Spacer()
                                Image(systemName: "trash.fill")
                                    .foregroundColor(.red)
                                    .font(.system(size: 40))
                                    .padding()
                                    .onTapGesture {
                                        for selectedEmoji in selectedEmojis {
                                            document.removeEmoji(selectedEmoji.id)
                                        }
                                    }
                            }
                            Spacer()
                        }
            )
            .clipped()
            .onDrop(of: [.plainText,.url,.image], isTargeted: nil) { providers, location in
                drop(providers: providers, at: location, in: geometry)
            }
            .gesture(panGesture())
            .gesture(selectedEmojis.isEmpty ? zoomGesture() : nil)
            .gesture(!selectedEmojis.isEmpty ? emojiZoomGesture() : nil)
        }
    }
    
    // MARK: - Drag and Drop
    
    private func drop(providers: [NSItemProvider], at location: CGPoint, in geometry: GeometryProxy) -> Bool {
        var found = providers.loadObjects(ofType: URL.self) { url in
            document.setBackground(.url(url.imageURL))
        }
        if !found {
            found = providers.loadObjects(ofType: UIImage.self) { image in
                if let data = image.jpegData(compressionQuality: 1.0) {
                    document.setBackground(.imageData(data))
                }
            }
        }
        if !found {
            found = providers.loadObjects(ofType: String.self) { string in
                if let emoji = string.first, emoji.isEmoji {
                    document.addEmoji(
                        String(emoji),
                        at: convertToEmojiCoordinates(location, in: geometry),
                        size: defaultEmojiFontSize / zoomScale
                    )
                }
            }
        }
        return found
    }
    
    // MARK: - Positioning/Sizing Emoji
    
    private func position(for emoji: EmojiArtModel.Emoji, in geometry: GeometryProxy) -> CGPoint {
        convertFromEmojiCoordinates((emoji.x, emoji.y), in: geometry)
    }
    
    private func fontSize(for emoji: EmojiArtModel.Emoji) -> CGFloat {
        CGFloat(emoji.size)
    }
    
    private func convertToEmojiCoordinates(_ location: CGPoint, in geometry: GeometryProxy) -> (x: Int, y: Int) {
        let center = geometry.frame(in: .local).center
        let location = CGPoint(
            x: (location.x - panOffset.width - center.x) / zoomScale,
            y: (location.y - panOffset.height - center.y) / zoomScale
        )
        return (Int(location.x), Int(location.y))
    }
    
    private func convertFromEmojiCoordinates(_ location: (x: Int, y: Int), in geometry: GeometryProxy) -> CGPoint {
        let center = geometry.frame(in: .local).center
        return CGPoint(
            x: center.x + CGFloat(location.x) * zoomScale + panOffset.width,
            y: center.y + CGFloat(location.y) * zoomScale + panOffset.height
        )
    }
    
    // MARK: - Zooming
    
    @State private var steadyStateZoomScale: CGFloat = 1
    @GestureState private var gestureZoomScale: CGFloat = 1
    
    private var zoomScale: CGFloat {
        steadyStateZoomScale * gestureZoomScale
    }
    
    private func zoomGesture() -> some Gesture {
        MagnificationGesture()
            .updating($gestureZoomScale) { latestGestureScale, gestureZoomScale, _ in
                gestureZoomScale = latestGestureScale
            }
            .onEnded { gestureScaleAtEnd in
                steadyStateZoomScale *= gestureScaleAtEnd
            }
    }
    
    private func doubleTapToZoom(in size: CGSize) -> some Gesture {
        TapGesture(count: 2)
            .onEnded {
                withAnimation {
                    zoomToFit(document.backgroundImage, in: size)
                }
            }
    }
    
    private func zoomToFit(_ image: UIImage?, in size: CGSize) {
        if let image = image, image.size.width > 0, image.size.height > 0, size.width > 0, size.height > 0  {
            let hZoom = size.width / image.size.width
            let vZoom = size.height / image.size.height
            steadyStatePanOffset = .zero
            steadyStateZoomScale = min(hZoom, vZoom)
        }
    }
    
    @State private var steadyStateEmojiZoomScale: CGFloat = 1
    @GestureState private var gestureEmojiZoomScale: CGFloat = 1
    
    private func emojiZoomGesture() -> some Gesture {
        MagnificationGesture()
            .updating($gestureEmojiZoomScale) { latestGestureScale, gestureEmojiZoomScale, _ in
                gestureEmojiZoomScale = latestGestureScale
            }
            .onEnded { gestureScaleAtEnd in
                if !selectedEmojis.isEmpty {
                    selectedEmojis.forEach { selectedEmoji in
                        document.scaleEmoji(selectedEmoji, by: gestureScaleAtEnd)
                    }
                } else {
                    steadyStateEmojiZoomScale *= gestureScaleAtEnd
                }
            }
    }
    
    // MARK: - Panning
    
    @State private var steadyStatePanOffset: CGSize = CGSize.zero
    @GestureState private var gesturePanOffset: CGSize = CGSize.zero
    
    private var panOffset: CGSize {
        (steadyStatePanOffset + gesturePanOffset) * zoomScale
    }
    
    private func panGesture() -> some Gesture {
        DragGesture()
            .updating($gesturePanOffset) { latestDragGestureValue, gesturePanOffset, _ in
                gesturePanOffset = latestDragGestureValue.translation / zoomScale
            }
            .onEnded { finalDragGestureValue in
                steadyStatePanOffset = steadyStatePanOffset + (finalDragGestureValue.translation / zoomScale)
            }
    }

    // MARK: - Palette
    
    var palette: some View {
        ScrollingEmojisView(emojis: testEmojis)
            .font(.system(size: defaultEmojiFontSize))
    }
    
    let testEmojis = "😀😷🦠💉👻👀🐶🌲🌎🌞🔥🍎⚽️🚗🚓🚲🛩🚁🚀🛸🏠⌚️🎁🗝🔐❤️⛔️❌❓✅⚠️🎶➕➖🏳️"
    
    // MARK: - Select emojis
    
    @State private var selectedEmojis = Set<EmojiArtModel.Emoji>()
    
    private func select(_ emoji: EmojiArtModel.Emoji) -> some Gesture {
        TapGesture()
            .onEnded {
                selectEmoji(emoji)
            }
    }
    
    private func selectEmoji(_ emoji: EmojiArtModel.Emoji) {
        selectedEmojis.toggleMatching(for: emoji)
    }
    
    private func isSelected(_ emoji: EmojiArtModel.Emoji) -> Bool {
        selectedEmojis.contains(where: { $0.id == emoji.id })
    }
    
    private func tapToDeselect() -> some Gesture {
        TapGesture()
            .onEnded {
                selectedEmojis.removeAll()
            }
    }
    
    // MARK: - Emojis gestures
    
    @State private var steadyStateDragEmojiOffset: CGSize = CGSize.zero
    @GestureState private var gestureDragEmojiOffset: CGSize = CGSize.zero
    
    private var dragEmojiOffset: CGSize {
        (steadyStateDragEmojiOffset + gestureDragEmojiOffset) * zoomScale
    }
    
    private func dragEmojiGesture(for emoji: EmojiArtModel.Emoji) -> some Gesture {
        DragGesture()
            .updating($gesturePanOffset) { latestDragGestureValue, gestureDragEmojiOffset, _ in
                gestureDragEmojiOffset = latestDragGestureValue.translation / zoomScale
            }
            .onEnded { finalDragGestureValue in
                let dragDistance = steadyStatePanOffset + (finalDragGestureValue.translation / zoomScale)
                if isSelected(emoji) {
                    for selectedEmoji in selectedEmojis {
                        document.moveEmoji(selectedEmoji, by: dragDistance)
                    }
                } else {
                    withAnimation {
                        document.moveEmoji(emoji, by: dragDistance)
                    }
                }
            }
    }
    
}

struct ScrollingEmojisView: View {
    let emojis: String

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(emojis.map { String($0) }, id: \.self) { emoji in
                    Text(emoji)
                        .onDrag { NSItemProvider(object: emoji as NSString) }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiArtDocumentView(document: EmojiArtDocument())
    }
}
