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

class GameDesk {
    var desk: [Int:[String:ChessMan]] = [:]
    init() {
        for i in 1...8 {
            desk[i] = [:]
        }
    }
    func setChessMan(chess: ChessMan, coordinates: (String, Int)) {
        let rowRange = 1...8
        let colRange = "A"..."H"
        if rowRange.contains(coordinates.1) && colRange.contains(coordinates.0) {
            self.desk[coordinates.1]![coordinates.0] = chess
            chess.setCoordinates(char: coordinates.0, num: coordinates.1)
        } else {
            print("coordinates out of range")
        }
    }
    subscript(alpha: String, number: Int) -> ChessMan? {
        get {
            return self.desk[number]![alpha]
        } set {
            if let chessman = newValue {
                self.setChessMan(chess: chessman, coordinates: (alpha, number))
            } else {
                self.desk[number]![alpha] = nil
            }
        }
    }
}

var gameDesk = GameDesk()
var queenBlack = ChessMan(type: .queen, color: .black, figureSymbol: "\u{265B}", coordinates: ("A", 6))
gameDesk.setChessMan(chess: queenBlack, coordinates: ("A", 3))
gameDesk["A", 3]?.coordinates
gameDesk["C", 5] = queenBlack
gameDesk["C", 5] = nil
gameDesk["C", 5]?.coordinates
