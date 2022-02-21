//
//  SetDeck.swift
//  Set
//
//  Created by Anvar Rahimov on 31.08.2021.
//

import Foundation

struct SetDeck {
    private(set) var cards = [SetCard]()
    
    init() {
        for shape in SetCard.Version.allCases {
            for fill in SetCard.Version.allCases {
                for color in SetCard.Version.allCases {
                    for number in SetCard.Version.allCases {
                        cards.append(
                            SetCard(shape: shape,
                                 fill: fill,
                                 color: color,
                                 number: number)
                        )
                    }
                }
            }
        }
        
        func draw() -> SetCard? {
            if cards.count > 0 {
                return cards.remove(at: Int.random(in: 0..<cards.count))
            } else {
                return nil
            }
        }
    }
    
    
}
