import UIKit

class Person {
    var residence: Residence?
}

class Residence {
    var rooms: [Room]?
    func roomsCount() -> Int {
        if let rooms = self.rooms {
            return rooms.count
        } else {
            return 1
        }
    }
}

class Room {
    var square: Int
    init(square: Int) {
        self.square = square
    }
}

var man = Person()
man.residence?.rooms
man.residence = Residence()
man.residence?.rooms

if let residence = man.residence {
    if let rooms = residence.rooms {
        rooms
        //[room]
    }
}

if let rooms = man.residence?.rooms {
    rooms
}

//initialization

let room1 = Room(square: 15)
let room2 = Room(square: 22)
man.residence?.rooms = [room1, room2]

//functions

man.residence?.roomsCount()

//subscripts

let firstRoom = man.residence?.rooms?[0]
type(of: firstRoom)

man.residence?.rooms?[0] = Room(square: 25)
man.residence?.rooms?[0].square
