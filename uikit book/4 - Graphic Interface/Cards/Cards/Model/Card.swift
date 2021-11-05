//
//  Card.swift
//  Cards
//
//  Created by Anvar Rahimov on 05.11.2021.
//

import UIKit

// типы фигуры карт
enum CardType: CaseIterable {
    case circle
    case cross
    case square
    case fill
}
// цвета карт
enum CardColor: CaseIterable {
    case red
    case green
    case black
    case gray
    case brown
    case yellow
    case purple
    case orange
}

// игральная карточка
typealias Card = (type: CardType, color: CardColor)

