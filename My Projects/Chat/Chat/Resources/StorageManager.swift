//
//  StorageManager.swift
//  Chat
//
//  Created by Anvar Rahimov on 13.03.2022.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    
    static let shared = StorageManager()
    
    private let storage = Storage.storage().reference()

}

//MARK: - File Management

extension StorageManager {
    
    public enum StorageError: Error {
        case failedToUpload
        case failedToGetDownloadURL
    }
    
    public typealias UploadPhotoCompletion = (Result<String, Error>) -> Void
    
    /// Uploads photo to firebase storage and returns completion with url-string to download
    func uploadProfilePhoto(with data: Data,
                                    fileName: String,
                                    completion: @escaping UploadPhotoCompletion) {
        storage.child("images: \(fileName)").putData(data, metadata: nil) { metadata, error in
            guard error == nil else {
                // failed
                completion(.failure(StorageError.failedToUpload))
                return
            }
            
            self.storage.child("images: \(fileName)").downloadURL { url, error in
                guard let url = url else {
                    completion(.failure(StorageError.failedToGetDownloadURL))
                    return
                }

                completion(.success(url.absoluteString))
            }
        }
    }
    
    public func downloadURL(for path: String, completion: @escaping (Result<URL, Error>) -> Void ) {
        let reference = storage.child(path)
        
        reference.downloadURL { url, error in
            guard let url = url, error == nil else {
                completion(.failure(StorageError.failedToGetDownloadURL))
                return
            }
            
            completion(.success(url))
        }
    }
}
