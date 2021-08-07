import UIKit

//incapsulation

class TVShow {}

protocol DisplayShow {
    func getShowList() -> Void
    func changeShowTo() -> Void
    var currentShow: TVShow { get }
}

protocol ChangeVolume {
    var currentVolume: UInt8 { get set }
    func increase(by: UInt8) -> Void
    func decrease(by: UInt8) -> Void
}

/*struct TV: DisplayShow, ChangeVolume {
    //
}*/

//polymorphism

/*struct DVDPlayer: ChangeVolume {
    
}

struct UniversalManager {
    var currentDevice: ChangeVolume
    func increaseVolume(by: UInt8) -> Void {
        self.currentDevice.currentVolume.increase(by: by)
    }
}

var manager = UniversalManager(currentDevice: DVDPlayer())
manager.increaseVolume(by: 1)

manager.currentDevice = TV()
manager.increaseVolume(by: 5)
*/

//pop

protocol Walking {}
protocol Flying {}
protocol Swimming {}

struct Duck: Walking, Flying, Swimming {}
struct Penguin: Walking, Swimming {}
