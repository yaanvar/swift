//
//  AppStateModel.swift
//  Messenger
//
//  Created by Anvar Rahimov on 11.08.2022.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth

class AppStateModel: ObservableObject {
    @AppStorage("currentUserName") var currentUserName: String = ""
    @AppStorage("currentEmail") var currentEmail: String = ""
    
    @Published var showingSignIn: Bool = true
    @Published var conversations: [String] = []
    @Published var messages: [Message] = []
    @Published var otherUserName = ""
    
    var database = Firestore.firestore()
    var auth = FirebaseAuth.Auth.auth()
    var conversationListener: ListenerRegistration?
    var chatListener: ListenerRegistration?
    
    init() {
        self.showingSignIn = Auth.auth().currentUser == nil
    }
    
}

// Search

extension AppStateModel {
    func searchUsers(queryText: String, completion: @escaping ([String]) -> Void) {
        database.collection("users")
            .getDocuments { snapshot, error in
                guard let usernames = snapshot?.documents.compactMap({ $0.documentID }),
                      error == nil else {
                    completion([])
                    return
                }
                
                let filtered = usernames.filter { username in
                    username.lowercased().hasPrefix(queryText.lowercased())
                }
                
                completion(filtered)
            }
    }
}

// Conversations

extension AppStateModel {
    func getConversations() {
        conversationListener = database
            .collection("users")
            .document(currentUserName)
            .collection("chats")
            .addSnapshotListener { [weak self] snapshot, error in
                guard let usernames = snapshot?.documents.compactMap({ $0.documentID }),
                error == nil else {
                    return
                }
                
                DispatchQueue.main.async {
                    self?.conversations = usernames
                }
            }
    }
}

// Get Chat/Send Messages

extension AppStateModel {
    func observeChat() {
        createConversation()
        
        chatListener = database
            .collection("users")
            .document(currentUserName)
            .collection("chats")
            .document(otherUserName)
            .collection("messsages")
            .addSnapshotListener { [weak self] snapshot, error in
                guard let objects = snapshot?.documents.compactMap({ $0.data() }),
                      error == nil else {
                    return
                }
                
                let messages: [Message] = objects.compactMap({
                    
                    guard let date = ISO8601DateFormatter().date(from: $0["created"] as? String ?? "") else {
                        return nil
                    }
                    
                    return Message(
                        text: $0["text"] as? String ?? "",
                        type: $0["sender"] as? String == self?.currentUserName ? .sent : .received,
                        created: date
                    )
                }).sorted { lhs, rhs in
                    return lhs.created < rhs.created
                }
                
                DispatchQueue.main.async {
                    self?.messages = messages
                }
            }
    }

    func sendMessage(text: String) {
        let newMessageId = UUID().uuidString
        let dateString = ISO8601DateFormatter().string(from: Date())
        
        let data = [
            "text": text,
            "sender": currentUserName,
            "created": dateString
        ]
        
        database
            .collection("users")
            .document(currentUserName)
            .collection("chats")
            .document(otherUserName)
            .collection("messages")
            .document(newMessageId)
            .setData(data)
        
        database
            .collection("users")
            .document(otherUserName)
            .collection("chats")
            .document(currentUserName)
            .collection("messages")
            .document(newMessageId)
            .setData(data)
    }
    
    func createConversation() {
        database
            .collection("users")
            .document(currentUserName)
            .collection("chats")
            .document(otherUserName)
            .setData(["created": "true"])
        
        database
            .collection("users")
            .document(otherUserName)
            .collection("chats")
            .document(currentUserName)
            .setData(["created": "true"])
    }
}

// Sign In & Sign Up users

extension AppStateModel {
    func signIn(username: String, password: String) {
        database.collection("users")
            .document(username)
            .getDocument { [weak self] snapshot, error in
                guard let email = snapshot?.data()?["email"] as? String, error == nil else {
                    return
                }
                
                self?.auth.signIn(withEmail: email, password: password) { result, error in
                    guard error == nil, result != nil else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self?.currentEmail = email
                        self?.currentUserName = username
                        self?.showingSignIn = false
                    }
                }
            }        
    }
    
    func signUp(emailAddress: String, username: String, password: String) {
        auth.createUser(withEmail: emailAddress, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            let data = [
                "email": emailAddress,
                "username": username
            ]
            
            self?.database
                .collection("users")
                .document(username)
                .setData(data) { error in
                    guard error == nil else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        self?.currentUserName = username
                        self?.currentEmail = emailAddress
                        self?.showingSignIn = false
                    }
                }
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
            self.showingSignIn = true
        } catch {
            print(error.localizedDescription)
        }
    }
}
