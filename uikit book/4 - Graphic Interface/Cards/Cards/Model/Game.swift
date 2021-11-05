//
//  Game.swift
//  Cards
//
//  Created by Anvar Rahimov on 05.11.2021.
//

import UIKit

class Game {
    // количество пар уникальных карточек
    var cardsCount = 0
    // массив сгенерированных карточек
    var cards = [Card]()
    
    // генерация массива случайных карт
    func generateCards() {
        // генерируем новый массив карточек
        var cards = [Card]()
        
        for _ in 0...cardsCount {
            let randomElement = (type: CardType.allCases.randomElement()!, color: CardColor.allCases.randomElement()!)
            cards.append(randomElement)
        }
        
        self.cards = cards
    }
    
    // проверка эквивалентности карточек
    func checkCards(_ firstCard: Card, _ secondCard: Card) -> Bool {
        if firstCard == secondCard {
            return true
        } else {
            return false
        }
    }
}
