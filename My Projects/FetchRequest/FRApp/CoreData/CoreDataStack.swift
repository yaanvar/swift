//
//  CoreDataStack.swift
//  FRApp
//
//  Created by n.gundorin on 27.03.2022.
//

import CoreData

protocol CoreDataStackProtocol {

    var viewContext: NSManagedObjectContext { get }

    func performTaskOnMainQueueContextAndSave(_ block: @escaping (NSManagedObjectContext) -> Void)
}

final class CoreDataStack: CoreDataStackProtocol {

    // MARK: Public properties

    var viewContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    // MARK: Private properties

    private let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FRApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: Public

    func performTaskOnMainQueueContextAndSave(_ block: @escaping (NSManagedObjectContext) -> Void) {
        viewContext.performAndWait {
            block(viewContext)
        }
        saveViewContext()
    }

    // MARK: Private

    private func saveViewContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
