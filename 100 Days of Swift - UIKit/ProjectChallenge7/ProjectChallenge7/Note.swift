//
//  Note.swift
//  ProjectChallenge7
//
//  Created by Anvar Rahimov on 20.02.2022.
//

import Foundation

class Note: Codable {
    var title: String
    var body: String
    
    init(title: String, body: String) {
        self.title = title
        self.body = body
    }
}
