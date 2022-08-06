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
    var date = Date()
    fileprivate(set) var isContacted = false
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
    
    let saveKey = "SavedData"
    
    enum SortFilter {
        case byName, mostRecent
    }
    
    init() {
        let filename = getDocumentsDirectory().appendingPathComponent(saveKey)
        
        do {
            let data = try Data(contentsOf: filename)
            people = try JSONDecoder().decode([Prospect].self, from: data)
        } catch {
            people = []
            print("Unable to load people from json.")
        }
    }
    
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent(saveKey)
        
        do {
            let data = try Data(contentsOf: filename)
            people = try JSONDecoder().decode([Prospect].self, from: data)
        } catch {
            print("Unable to load people from json.")
        }
    }
    
    func save() {
        do {
            let filename = getDocumentsDirectory().appendingPathComponent(saveKey)
            let data = try JSONEncoder().encode(people)
            try data.write(to: filename, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save people in json.")
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    func sortWith(filter: SortFilter) {
        switch filter {
        case .byName:
            people = people.sorted { lhs, rhs in
                lhs.name < rhs.name
            }
        case .mostRecent:
            people = people.sorted { lhs, rhs in
                lhs.date > rhs.date
            }
        }
    }
}

func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}
