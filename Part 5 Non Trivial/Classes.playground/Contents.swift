import UIKit

class ChessMan {
    
    let type: ChessManType
    let color: ChessManColor
    var coordinates: (String, Int)? = nil
    let figureSymbol: Character
    init(type: ChessManType, color: ChessManColor, figureSymbol: Character) {
        self.type = type
        self.color = color
        self.figureSymbol = figureSymbol
    }
    init(type: ChessManType, color: ChessManColor, figureSymbol: Character, coordinates: (String, Int)) {
        self.type = type
        self.color = color
        self.figureSymbol = figureSymbol
        setCoordinates(char: coordinates.0, num: coordinates.1)
    }
    enum ChessManType {
        case king, queen, castle, knight, bishop, pawn
    }
    enum ChessManColor {
        case black, white
    }
    func setCoordinates(char: String, num: Int) {
        coordinates = (char, num)
    }
    func kill() {
        coordinates = nil
    }
    
}

var kingWhite = ChessMan.init(type: .king, color: .white, figureSymbol: "\u{2654}")

//link

var linkToTheValue = ChessMan.ChessManType.bishop
