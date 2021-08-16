//
//  Themes.swift
//  Memorize Assignment 2
//
//  Created by Anvar Rahimov on 16.08.2021.
//

import Foundation

struct Theme {
    private(set) var name: String
    private(set) var emojis: [String]
    private(set) var themeColor: String
    init(name: String, emojis: [String], themeColor: String) {
        self.name = name
        self.emojis = emojis
        self.themeColor = themeColor
    }
}

var themes: [Theme] = []
//themes.append(Theme(name: "Flags",
//                   emojis: ["🏳️", "🏳️‍🌈", "🏳️‍⚧️", "🏴‍☠️", "🏁", "🏴", "🚩", "🎌", "🇯🇵"],
//                   themeColor: "blue"))
//themes.append(Theme(name: "Vehicles",
//                    emojis: ["✈️", "🚂", "🛸", "🚀", "🚗", "🚑", "🚒", "🚜", "🚲", "🛴", "🏍", "🚄", "🚁", "🚤", "🚡", "🚟", "🚌", "🚚", "🛶", "🛺", "🛵", "🛻", "🦽", "🚃"],
//                        themeColor: "red"))
//themes.append(Theme(name: "Smiles",
//                                emojis: ["😀", "🤩", "🥳", "😎", "😜", "😘", "😇", "🥺", "😂", "😆", "😅"],
//                                themeColor: "yellow"))
//themes.append(Theme(name: "Food",
//                    emojis: ["🍋", "🫒", "🍓", "🍑", "🥝", "🍅", "🍆", "🥑", "🥥", "🍒", "🍇", "🍉", "🍌", "🍏"],
//                    themeColor: "green"))
//themes.append(Theme(name: "Tech",
//                    emojis: ["🎥", "📼", "📟", "📻", "📺", "📷", "💾", "🕹", "🖨", "🖱", "⌨️", "🖥", "💻", "📱", "⌚️"], themeColor: "purple"))

let halloween = Theme(name: "Halloween",
                      emojis: ["💀", "👻", "🎃", "🧟‍♀️", "👺", "👹", "🎭"],
                      themeColor: "orange")

let flag = Theme(name: "Flags",
                 emojis: ["🏳️", "🏳️‍🌈", "🏳️‍⚧️", "🏴‍☠️", "🏁", "🏴", "🚩", "🎌", "🇯🇵"],
                 themeColor: "blue")

let vehicle = Theme(name: "Vehicles",
                    emojis: ["✈️", "🚂", "🛸", "🚀", "🚗", "🚑", "🚒", "🚜", "🚲", "🛴", "🏍", "🚄", "🚁", "🚤", "🚡", "🚟", "🚌", "🚚", "🛶", "🛺", "🛵", "🛻", "🦽", "🚃"],
                        themeColor: "red")

let smile = Theme(name: "Smiles",
                   emojis: ["😀", "🤩", "🥳", "😎", "😜", "😘", "😇", "🥺", "😂", "😆", "😅"],
                   themeColor: "yellow")

let food = Theme(name: "Food",
                 emojis: ["🍋", "🫒", "🍓", "🍑", "🥝", "🍅", "🍆", "🥑", "🥥", "🍒", "🍇", "🍉", "🍌", "🍏"],
                 themeColor: "green")


let tech = Theme(name: "Tech",
                 emojis: ["🎥", "📼", "📟", "📻", "📺", "📷", "💾", "🕹", "🖨", "🖱", "⌨️", "🖥", "💻", "📱", "⌚️"], themeColor: "purple")
