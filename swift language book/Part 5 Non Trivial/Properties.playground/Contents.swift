import UIKit

class Person {
    
    var firstName: String = "Name"
    var secondName: String = "Surname"
    lazy var wholeName = self.generateWholeName()
    func generateWholeName() -> String {
        return firstName + " " + secondName
    }
    init(name: String, surname: String) {
        (self.firstName,  self.secondName) = (name, surname)
    }
    
    lazy var wholeName2: ()->String = { "\(self.firstName) \(self.secondName)" }
    
    var wholeName3: String { return "\(self.firstName) \(self.secondName)" }
}

var me = Person(name: "Gachi", surname: "Muchi")
me.wholeName

//lazy-by-need

me.wholeName
me.secondName = "Gang"
me.wholeName

//closure wholeName2

me.wholeName2()
me.secondName = "Muchi"
me.wholeName2()

//evaluating type

me.wholeName3
me.secondName = "Gang"
me.wholeName3

//getter and setter

struct Circle {
    
    var coordinates: (x: Int, y: Int)
    var radius: Float {
        willSet {
            print("New value of radius \(newValue) replaced old value of radius \(radius)")
        }
        didSet {
            print("Old value of radius \(oldValue) was changed on new value \(radius)")
        }
    }
    var perimetr: Float {
        get {
            return 2 * 3.14 * radius
        }
        set {
            radius = newValue / (2 * 3.14)
        }
    }
    
}

var myCircle = Circle(coordinates: (0, 0), radius: 10)
myCircle.perimetr
myCircle.perimetr = 42
myCircle.radius

//static propertirs

struct AudioChannel {
    static var maxVolume = 5
    var currentVolume: Int {
        didSet {
            if currentVolume > AudioChannel.maxVolume {
                currentVolume = AudioChannel.maxVolume
            }
        }
    }
}

var rightChannel = AudioChannel(currentVolume: 3)
var leftChannel = AudioChannel(currentVolume: 4)
rightChannel.currentVolume = 7
rightChannel.currentVolume
AudioChannel.maxVolume = 10
rightChannel.currentVolume = 8
rightChannel.currentVolume
