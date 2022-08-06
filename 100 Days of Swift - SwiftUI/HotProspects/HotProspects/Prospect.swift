//
//  Prospect.swift
//  HotProspects
//
//  Created by Anvar Rahimov on 06.08.2022.
//

import Foundation

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published var people: [Prospect]
    
    init() {
        self.people = []
    }
    
    
}
