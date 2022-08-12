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
    
    var database = Firestore.firestore()
    var auth = FirebaseAuth.Auth.auth()
    
}

// Search

extension AppStateModel {
    func searchUsers(queryText: String, completion: @escaping ([String]) -> Void) {
        
    }
}

// Conversations

extension AppStateModel {
    func getConversations() {
        
    }
}

// Get Chat/Send Messages

extension AppStateModel {
    func observeChat() {
        
    }

    func sendMessage(text: String) {
        
    }
    
    func createConversationIfNeeded() {
        
    }
}

// Sign In & Sign Up users

extension AppStateModel {
    func signIn(username: String, password: String) {
        
    }
    
    func signUp(emailAddress: String, username: String, password: String) {
        
    }
}
