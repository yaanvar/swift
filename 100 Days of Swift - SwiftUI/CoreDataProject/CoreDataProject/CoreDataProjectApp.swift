//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Anvar Rahimov on 15.07.2022.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
