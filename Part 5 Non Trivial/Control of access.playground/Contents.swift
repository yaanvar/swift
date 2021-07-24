import UIKit

 public class User { //everything in swift is internal which means it's working in module's files where it was initialized
    init() {}
}

open class UserManager { //open - fully open everywhere for everyone for everything
    public var currentUser: User //public - open only in module where it's workgng
    public func loadUser() {
        
    }
    public func createUser(withLogin login: String) {
    
    }
    private func saveToStorage() { //private works only in construction where it was initialized
    
    }
    private func generatePassword() {
    
    }
    init (someUser: User) {
        currentUser = someUser
    }
}
