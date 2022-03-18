//
//  DatabaseManager.swift
//  MicroBlog
//
//  Created by Anvar Rahimov on 17.03.2022.
//

import Foundation
import FirebaseFirestore

final class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Firestore.firestore()
    
    public func insertBlogPost(
        post: Post,
        user: User,
        completion: @escaping (Bool) -> Void
    ) {
        
    }
    
    public func getAllPosts(
        completion: @escaping ([Post]) -> Void
    ) {
        
    }
    
    public func getPosts(
        for user: User,
        completion: @escaping ([Post]) -> Void
    ) {
        
    }
    
    public func insert(
        user: User,
        completion: @escaping (Bool) -> Void
    ) {
        let documentId = user.email.replacingOccurrences(of: ".", with: "_").replacingOccurrences(of: "@", with: "_")
        
        let data = [
            "email": user.email,
            "name": user.name
        ]
        
        database.collection("users").document(documentId).setData(data) { error in
            completion(error == nil)
        }
    }
    
    public func getUser(email: String, completion: @escaping (User?) -> Void) {
        let documentId = email.replacingOccurrences(of: ".", with: "_").replacingOccurrences(of: "@", with: "_")
        
        database.collection("users").document(documentId).getDocument { snapshot, error in
            guard let data = snapshot?.data() as? [String: String],
                  let name = data["name"],
                  error == nil else {
                return
            }
            
            var referrence = data["profile_photo"]
            let user = User(name: name, email: email, profilePictureReferrence: referrence)
            completion(user)
            
        }
    }
    
    public func updateProfilePhoto(email: String, completion: @escaping (Bool) -> Void) {
        let path = email.replacingOccurrences(of: "@", with: "_").replacingOccurrences(of: ".", with: "_")
        let photoReferrence = "profile_photo/\(path)/photo.png"
        let databaseReferrence = database.collection("users").document(path)
        
        databaseReferrence.getDocument { snapshot, error in
            guard var data = snapshot?.data(), error == nil else {
                return
            }
            
            data["profile_photo"] = photoReferrence
            
            databaseReferrence.setData(data) { error in
                completion(error == nil)
            }
        }
    }
    
}
