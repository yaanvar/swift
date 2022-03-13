//
//  DatabaseManager.swift
//  Chat
//
//  Created by Anvar Rahimov on 12.03.2022.
//

import Foundation
import FirebaseDatabase

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
}

//MARK: - Account Management

extension DatabaseManager {
    
    /// Checks if a user with the given email address exists in the database
    public func userExists(with email: String,
                           completion: @escaping ((Bool) -> Void)) {
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value) { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
        }
        
    }
    
    /// Inserts new user to database
    public func insertUser(with user: ChatUser, completion: @escaping ((Bool) -> Void)) {
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ]) { error, _ in
            guard error == nil else {
                print("failed to write to database")
                completion(false)
                return
            }
            
            completion(true)
        }
    }
    
}

struct ChatUser {
    let firstName: String
    let lastName: String
    let email: String
    var safeEmail: String {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    var profilePhotoFileName: String {
        return "\(safeEmail)_profile_photo.png"
    }
}
