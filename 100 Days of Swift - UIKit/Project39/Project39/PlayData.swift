//
//  PlayData.swift
//  Project39
//
//  Created by Anvar Rahimov on 11.03.2022.
//

import Foundation

class PlayData {
    var allWords = [String]()
    var wordCounts = [String: Int]()
    var filteredWords = [String]()
    
    init() {
        if let path = Bundle.main.path(forResource: "plays", ofType: "txt") {
            if let plays = try? String(contentsOfFile: path) {
                allWords = plays.components(separatedBy: CharacterSet.alphanumerics.inverted)
                allWords = allWords.filter { $0 != "" }
                for word in allWords {
                    wordCounts[word, default: 0] += 1
                }
                allWords = Array(wordCounts.keys)
            }
        }
    }
    
    func applyFilter(_ filter: (String) -> Bool) {
        filteredWords = allWords.filter(filter)
    }
    
    func applyUserFilter(_ input: String) {
        if let userNumber = Int(input) {
            //applyFilter { self.wordCounts.count(for: $0) >= userNumber }
        } else {
            applyFilter { $0.range(of: input, options: .caseInsensitive) != nil }
        }
    }
}
