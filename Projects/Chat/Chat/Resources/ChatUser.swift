//
//  ChatUser.swift
//  Chat
//
//  Created by Anvar Rahimov on 17.03.2022.
//

import Foundation

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
