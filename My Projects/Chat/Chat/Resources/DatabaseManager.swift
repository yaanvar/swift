//
//  DatabaseManager.swift
//  Chat
//
//  Created by Anvar Rahimov on 12.03.2022.
//

import Foundation
import FirebaseDatabase
import UIKit

final class DatabaseManager {
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    static func safeEmail(email: String) -> String {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
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
            
            self.database.child("users").observeSingleEvent(of: .value) { snapshot in
                if var usersCollection = snapshot.value as? [[String: String]] {
                    let newElement = [
                        "name": user.firstName + " " + user.lastName,
                        "safeEmail": user.safeEmail
                    ]
                    usersCollection.append(newElement)
                    
                    self.database.child("users").setValue(usersCollection) { error, _ in
                        guard error == nil else {
                            completion(false)
                            return
                        }
                        
                        completion(true)
                    }
                    
                } else {
                    let newCollection: [[String: String]] = [
                        [
                            "name": user.firstName + " " + user.lastName,
                            "safeEmail": user.safeEmail
                        ]
                    ]
                    
                    self.database.child("users").setValue(newCollection) { error, _ in
                        guard error == nil else {
                            completion(false)
                            return
                        }
                        
                        completion(true)
                    }
                }
            }
            
            completion(true)
        }
    }
    
    /// Fetches all users from firebase
    public func getAllUsers(completion: @escaping (Result<[[String: String]], Error>) -> Void) {
        database.child("users").observeSingleEvent(of: .value) { snapshot in
            guard let value = snapshot.value as? [[String: String]] else {
                completion(.failure(DataBaseError.failedToFetch))
                return
            }
            
            completion(.success(value))
        }
    }
    
    public enum DataBaseError: Error {
        case failedToFetch
    }
    
}

//MARK: - Sending Messages/Conversations

extension DatabaseManager {
    
    /// Creates a new conversation with target user emamil and first message sent
        public func createNewConversation(with otherUserEmail: String, name: String, firstMessage: Message, completion: @escaping (Bool) -> Void) {
            guard let currentEmail = UserDefaults.standard.value(forKey: "email") as? String,
                let currentNamme = UserDefaults.standard.value(forKey: "name") as? String else {
                    return
            }
            let safeEmail = DatabaseManager.safeEmail(email: currentEmail)

            let ref = database.child("\(safeEmail)")

            ref.observeSingleEvent(of: .value, with: { [weak self] snapshot in
                guard var userNode = snapshot.value as? [String: Any] else {
                    completion(false)
                    print("user not found")
                    return
                }

                let messageDate = firstMessage.sentDate
                let dateString = ChatViewController.dateFormatter.string(from: messageDate)

                var message = ""

                switch firstMessage.kind {
                case .text(let messageText):
                    message = messageText
                case .attributedText(_):
                    break
                case .photo(_):
                    break
                case .video(_):
                    break
                case .location(_):
                    break
                case .emoji(_):
                    break
                case .audio(_):
                    break
                case .contact(_):
                    break
                case .custom(_), .linkPreview(_):
                    break
                }

                let conversationId = "conversation_\(firstMessage.messageId)"

                let newConversationData: [String: Any] = [
                    "id": conversationId,
                    "other_user_email": otherUserEmail,
                    "name": name,
                    "latest_message": [
                        "date": dateString,
                        "message": message,
                        "is_read": false
                    ]
                ]

                let recipient_newConversationData: [String: Any] = [
                    "id": conversationId,
                    "other_user_email": safeEmail,
                    "name": currentNamme,
                    "latest_message": [
                        "date": dateString,
                        "message": message,
                        "is_read": false
                    ]
                ]
                
                self?.database.child("\(otherUserEmail)/conversations").observeSingleEvent(of: .value, with: { [weak self] snapshot in
                    if var conversatoins = snapshot.value as? [[String: Any]] {
                        conversatoins.append(recipient_newConversationData)
                        self?.database.child("\(otherUserEmail)/conversations").setValue(conversatoins)
                    }
                    else {
                        self?.database.child("\(otherUserEmail)/conversations").setValue([recipient_newConversationData])
                    }
                })

                if var conversations = userNode["conversations"] as? [[String: Any]] {
                    conversations.append(newConversationData)
                    userNode["conversations"] = conversations
                    ref.setValue(userNode, withCompletionBlock: { [weak self] error, _ in
                        guard error == nil else {
                            completion(false)
                            return
                        }
                        self?.finishCreatingConversation(name: name,
                                                         conversationID: conversationId,
                                                         firstMessage: firstMessage,
                                                         completion: completion)
                    })
                }
                else {
                    userNode["conversations"] = [
                        newConversationData
                    ]

                    ref.setValue(userNode, withCompletionBlock: { [weak self] error, _ in
                        guard error == nil else {
                            completion(false)
                            return
                        }

                        self?.finishCreatingConversation(name: name,
                                                         conversationID: conversationId,
                                                         firstMessage: firstMessage,
                                                         completion: completion)
                    })
                }
            })
        }

        private func finishCreatingConversation(name: String, conversationID: String, firstMessage: Message, completion: @escaping (Bool) -> Void) {
    //        {
    //            "id": String,
    //            "type": text, photo, video,
    //            "content": String,
    //            "date": Date(),
    //            "sender_email": String,
    //            "isRead": true/false,
    //        }
            let messageDate = firstMessage.sentDate
            let dateString = ChatViewController.dateFormatter.string(from: messageDate)

            var message = ""
            switch firstMessage.kind {
            case .text(let messageText):
                message = messageText
            case .attributedText(_), .photo(_), .video(_), .location(_), .emoji(_), .audio(_), .contact(_),.custom(_), .linkPreview(_):
                break
            }

            guard let myEmail = UserDefaults.standard.value(forKey: "email") as? String else {
                completion(false)
                return
            }

            let currentUserEmail = DatabaseManager.safeEmail(email: myEmail)

            let collectionMessage: [String: Any] = [
                "id": firstMessage.messageId,
                "type": firstMessage.kind.messageKindString,
                "content": message,
                "date": dateString,
                "sender_email": currentUserEmail,
                "is_read": false,
                "name": name
            ]

            let value: [String: Any] = [
                "messages": [
                    collectionMessage
                ]
            ]

            print("adding convo: \(conversationID)")

            database.child("\(conversationID)").setValue(value, withCompletionBlock: { error, _ in
                guard error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            })
        }
    
    /// Fetches and returns all conversations for the user with passed in email
    public func getAllConversations(for email: String, completion: @escaping (Result<String, Error>) -> Void) {
        
    }
    
    /// Fetches and returns  all messages for conversation with passed in id
    public func getAllMessagesForConversation(for id: String, completion: @escaping (Result<String, Error>) -> Void) {
        
    }
    
    /// Sends a message with target conversation and message
    public func sendMessage(to conversation: String, message: Message, completion: @escaping (Bool) -> Void) {
        
    }

}
