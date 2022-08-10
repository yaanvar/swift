//
//  StorageManager.swift
//  MicroBlog
//
//  Created by Anvar Rahimov on 17.03.2022.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    
    static let shared = StorageManager()
    
    private let container = Storage.storage().reference()
    
    public func uploadUserProfilePicture(
        email: String,
        image: UIImage?,
        completion: @escaping (Bool) -> Void
    ) {
        let path = email.replacingOccurrences(of: "@", with: "_").replacingOccurrences(of: ".", with: "_")
        guard let pngData = image?.pngData() else {
            return
        }
        
        Storage.storage().reference(withPath: "profile_photo/\(path)/photo.png").putData(pngData, metadata: nil) { metadata, error in
            guard metadata != nil, error == nil else {
                completion(true)
                return
            }
            completion(false)
        }
    }
    
    public func downloadURLForProfilePicture(
        path: String,
        completion: @escaping (URL?) -> Void
    ) {
        container.storage.reference(withPath: path).downloadURL { url, _ in
            completion(url )
        }
    }
    
    public func uploadPostHeaderImage(
        post: Post,
        image: UIImage?,
        completion: @escaping (Bool) -> Void
    ) {
        
    }
    
    public func downloadURLForPostHeader(
        post: Post,
        completion: @escaping (URL?) -> Void
    ) {
        
    }
    
}
