import UIKit

//MARK: - Autoclosures

var arrayOfNames = ["Helga", "Bazil", "Alex"]
func printName(nextName: @autoclosure ()->String) {
    print(nextName())
}
printName(nextName: arrayOfNames.remove(at: 0))

//MARK: - Escaping closures

var arrayOfClosures: [()->Int] = []
func addNewClosureInArray(_ newClosure: @escaping ()->Int) {
    arrayOfClosures.append(newClosure)
}
addNewClosureInArray({return 100})
addNewClosureInArray{return 1000}
arrayOfClosures[0]()
arrayOfClosures[1]()

//MARK: - Static


struct AudioChannel {
    static var maxVolume = 5
    var volume: Int {
        didSet {
            if volume > AudioChannel.maxVolume {
                volume = AudioChannel.maxVolume
            }
} }
}
var LeftChannel = AudioChannel(volume: 2)
var RightChannel = AudioChannel(volume: 3)
RightChannel.volume = 6
RightChannel.volume // 5
AudioChannel.maxVolume // 5
AudioChannel.maxVolume = 10
AudioChannel.maxVolume // 10
RightChannel.volume = 8
RightChannel.volume // 8

//MARK: - Subscripts

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

//MARK: - Inheritance

class Quadruped {
    var type = ""
    var name = ""
    func walk() {
        print("walk")
    }
    init() {}
}

class Dog: Quadruped {
    func bark() {
        print("woof")
    }
    func printName() {
        print(self.name)
    }
    override init() {
        super.init()
        self.type = "dog"
    }
}

var dog = Dog()
dog.type = "dog"
dog.walk()
dog.bark()

dog.name = "Kagyr Maur Diffin Aep-Keallah"
dog.printName()

//override

final class NoisyDog: Dog {
    override func bark() {
        for _ in 1...3 {
            super.bark()
        }
    }
}

var noisyDog = NoisyDog()
noisyDog.bark()

//

var animalsArray: [Quadruped] = []
var someAnimal = Quadruped()
var myDog = Dog()
var sadDog = NoisyDog()
animalsArray.append(someAnimal)
animalsArray.append(myDog)
animalsArray.append(sadDog)

for item in animalsArray {
    print(type(of: item))
}

//

for item in animalsArray {
    if item is Dog {
        print("yeap")
    }
}

//

for item in animalsArray {
    if let animal = item as? NoisyDog {
        animal.bark()
    } else if let animal = item as? Dog {
        animal.bark()
    } else {
        item.walk()
    }
}



