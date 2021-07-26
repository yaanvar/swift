import UIKit

class Application {
    var name: String
    
    init(name: String) {
        print("creating instance")
        self.name = name
    }
    
    deinit {
        print("destroying instance")
    }
}

func loadResources(forApp: Application) {
    print("start of the function loadResources")
    let _ = "./bin/\(forApp.name)/"
    //
    print("end of the function loadResources")
}

func main(testMode: Bool) {
    print("start of the function main")
    let app = Application(name: "Calculator")
    loadResources(forApp: app)
    //
    print("end of the function main")
}

main(testMode: true)

//deinit instances

print()

class House {
    var title: String
    var owner: Human?
    
    init(title: String, owner: Human? = nil) {
        print("House of \(title) created")
        self.owner = owner
        self.title = title
        return
    }
    
    deinit {
        print("House of \(title) destroyed")
    }
}

class Human {
    var name: String
    
    init(name: String) {
        print("Owner \(name) created")
        self.name = name
        return
    }
    
    deinit {
        print("Owner \(name) destroyed")
    }
}

if true {
    let houseOwner = Human(name: "Anvar")
    if true {
        let _ = House(title: "House", owner: houseOwner)
    }
    let _ = House(title: "Flat", owner: houseOwner)
}

//memory leak and ARC

print()

//strong, weak and unowned references

//references in closures

var a = 2
let f = { return a }
f()
a = 3
f()

class Man {
    var name: String = "Human"
    deinit {
        print("Human deleted")
    }
}
var closure: (() -> Void)?

if true {
    let man = Man()
    closure = { [unowned man] in
      print(man.name)
    }
    closure!()
}
print("Program has ended")
