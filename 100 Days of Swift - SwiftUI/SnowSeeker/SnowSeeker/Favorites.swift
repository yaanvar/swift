//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Anvar Rahimov on 09.08.2022.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String>

    private let saveKey = "Favorites"

    init() {
        if let savedSet = UserDefaults.standard.array(forKey: saveKey) as? [String] {
            resorts = Set(savedSet)
            return
        }
        
        resorts = []
    }

    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        UserDefaults.standard.set(Array(resorts), forKey: saveKey)
    }
}
