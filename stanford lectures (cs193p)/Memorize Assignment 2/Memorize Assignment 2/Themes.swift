//
//  Themes.swift
//  Memorize Assignment 2
//
//  Created by Anvar Rahimov on 16.08.2021.
//

import SwiftUI

struct Theme: Codable, Identifiable {
    var name: String
    var emojis: String
    var numberOfPairsOfCards: Int
    var themeColor: RGBAColor
    var id: Int
    init(name: String, emojis: String, numberOfPairsOfCards: Int, themeColor: RGBAColor, id: Int) { //make fileprivate later
        self.name = name
        self.emojis = emojis
        self.id = id
        
        if numberOfPairsOfCards > emojis.count {
            self.numberOfPairsOfCards = emojis.count
        } else {
            self.numberOfPairsOfCards = numberOfPairsOfCards
        }
        
        self.themeColor = themeColor
    }
    
    // MARK: - Theme(s)
}

class ThemeStore: ObservableObject {
    let name: String
    
    @Published var themes = [Theme]() {
        didSet {
            storeInUserDefaults()
        }
    }
    
    private var userDefaultsKey: String {
        "ThemeStore" + name
    }
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(themes), forKey: userDefaultsKey)
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedThemes = try? JSONDecoder().decode(Array<Theme>.self, from: jsonData) {
            themes = decodedThemes
        }
    }
    
    init(named name: String) {
        self.name = name
        restoreFromUserDefaults()
        if themes.isEmpty {
            print("using built-in themes")
            insertTheme(named: "Halloween", emojis: "💀👻🎃🧟‍♀️👺👹🎭", themeColor: RGBAColor(color: .orange), numberOfPairsOfCards: 5, id: 0)
            insertTheme(named: "Flags", emojis: "🏳️🏳️‍🌈🏳️‍⚧️🏴‍☠️🏁🏴🚩🎌🇯🇵", themeColor: RGBAColor(color: .blue), numberOfPairsOfCards: 6, id: 1)
            insertTheme(named: "Smiles", emojis: "😀🤩🥳😎😜😘😇🥺😂😆😅", themeColor: RGBAColor(color: .yellow), numberOfPairsOfCards: 7, id: 2)
            insertTheme(named: "Food", emojis: "🍋🫒🍓🍑🥝🍅🍆🥑🥥🍒🍇🍉🍌🍏", themeColor: RGBAColor(color: .green), numberOfPairsOfCards: 8, id: 3)
            insertTheme(named: "Tech", emojis: "🎥📼📟📻📺📷💾🕹🖨🖱⌨️🖥💻📱⌚️", themeColor: RGBAColor(color: .purple), numberOfPairsOfCards: 10, id: 4)
            insertTheme(named: "Vehicles", emojis: "✈️🚂🛸🚀🚗🚑🚒🚜🚲🛴🏍🚄🚁🚤🚡🚟🚌🚚🛶🛺🛵🛻🦽🚃", themeColor: RGBAColor(color: .red), numberOfPairsOfCards: 10, id: 5)
        } else {
            print("successfully loaded themes from UserDefaults: \(themes)")
        }
    }

    
    // MARK: -Intent(s)
    
    func theme(at index: Int) -> Theme {
        let safeIndex = min(max(index, 0), themes.count - 1)
        return themes[safeIndex]
    }
    
    @discardableResult
    func removePalette(at index: Int) -> Int {
        if themes.count > 1, themes.indices.contains(index) {
            themes.remove(at: index)
        }
        return index % themes.count
    }
    
    func insertTheme(named name: String, emojis: String? = nil, themeColor: RGBAColor, numberOfPairsOfCards: Int, id: Int, at index: Int = 0) {
        let unique = (themes.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        let palette = Theme(name: name, emojis: emojis ?? "", numberOfPairsOfCards: numberOfPairsOfCards, themeColor: themeColor, id: unique)
        let safeIndex = min(max(index, 0), themes.count)
        themes.insert(palette, at: safeIndex)
    }
}
