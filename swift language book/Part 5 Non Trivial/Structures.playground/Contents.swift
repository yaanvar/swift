import UIKit

struct ChessPlayer {
    
    var name: String = "Dungeon Master"
    var victories: UInt = 0
    init(name: String) {
        self.name = name
    }
    func desctiption() {
        print("Player \(name) won \(victories) games")
    }
    mutating func addVictories(count: UInt = 1) {
        victories += count
    }
}

var playerSlava = ChessPlayer.init(name: "Slava")
type(of: playerSlava)
let unknownPlayer = ChessPlayer(name: "Dungeon Master")
unknownPlayer.name

//struct as a namespace

playerSlava.victories += 41
playerSlava.victories

//metods

playerSlava.desctiption()
playerSlava.addVictories()
playerSlava.desctiption()
