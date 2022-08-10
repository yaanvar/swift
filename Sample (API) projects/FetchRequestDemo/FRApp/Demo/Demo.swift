//
//  Demo.swift
//  FRApp
//
//  Created by n.gundorin on 03.04.2022.
//

import CoreData

protocol DemoFetchRequest {
    func demoFetchRequest()
}

protocol DemoFetchedResultsController {
    func demoFetchedResultsController()
}

final class Demo {

    // MARK: Private properties

    private let coreDataStack: CoreDataStackProtocol

    // MARK: Init

    init(coreDataStack: CoreDataStackProtocol) {
        self.coreDataStack = coreDataStack

        prepareData()
    }
}

// MARK: - Demo NSFetchRequest

extension Demo: DemoFetchRequest {

    func demoFetchRequest() {
        coreDataStack.performTaskOnMainQueueContextAndSave { [weak self] context in
            guard let self = self else { return }

            do {
                try self.simpleFetchRequest(context)
//                try self.fetchRequestWithSorting(context)
//                try self.fetchRequestWithPredicate(context)
//                try self.fetchRequestLimitAndOffset(context)
//                try self.fetchRequestWithCountResultTypeCount(context)
//                try self.fetchRequestWithCountResultTypeFetch(context)
//                try self.fetchRequestWithDictionaryResultType(context)
//                try self.fetchRequestWithFaults(context)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    private func simpleFetchRequest(_ context: NSManagedObjectContext) throws {
        let fetchRequest = Person.fetchRequest()

        let results = try context.fetch(fetchRequest)

        results.forEach { $0.printDescription() }
    }

    private func fetchRequestWithSorting(_ context: NSManagedObjectContext) throws {
        let fetchRequest = Person.fetchRequest()

        let salarySortDescriptor = NSSortDescriptor(key: #keyPath(Person.salary), ascending: true)
        fetchRequest.sortDescriptors = [salarySortDescriptor]

        let results = try context.fetch(fetchRequest)

        results.forEach { $0.printDescription() }
    }

    private func fetchRequestWithPredicate(_ context: NSManagedObjectContext) throws {
        let fetchRequest = Person.fetchRequest()

        fetchRequest.predicate = NSPredicate(format: "position = %@", "iOS developer")

        let results = try context.fetch(fetchRequest)

        results.forEach { $0.printDescription() }
    }

    private func fetchRequestLimitAndOffset(_ context: NSManagedObjectContext) throws {
        let fetchRequest = Person.fetchRequest()

        fetchRequest.sortDescriptors = [NSSortDescriptor(key: #keyPath(Person.salary), ascending: true)]

        fetchRequest.fetchLimit = 3
        fetchRequest.fetchOffset = 2

        let results = try context.fetch(fetchRequest)

        results.forEach { $0.printDescription() }
    }

    private func fetchRequestWithCountResultTypeCount(_ context: NSManagedObjectContext) throws {
        let fetchRequest = Person.fetchRequest()

        fetchRequest.predicate = NSPredicate(format: "salary > %d", 1000)
        fetchRequest.resultType = .countResultType

        let count = try context.count(for: fetchRequest)

        print(count)
    }

    private func fetchRequestWithCountResultTypeFetch(_ context: NSManagedObjectContext) throws {
        let fetchRequest: NSFetchRequest<NSNumber> = NSFetchRequest(entityName: "Person")

        fetchRequest.predicate = NSPredicate(format: "salary > %d", 1000)
        fetchRequest.resultType = .countResultType

        let count = try context.fetch(fetchRequest)

        print(count)
    }

    private func fetchRequestWithDictionaryResultType(_ context: NSManagedObjectContext) throws {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Person")

        fetchRequest.resultType = .dictionaryResultType
        fetchRequest.propertiesToFetch = ["position"]

        let results = try context.fetch(fetchRequest)

        print(results)
    }

    // Note: Disable prepareData()
    private func fetchRequestWithFaults(_ context: NSManagedObjectContext) throws {
        let fetchRequest = Department.fetchRequest()

        fetchRequest.predicate = NSPredicate(format: "name = %@", "Main")

        guard let department = try context.fetch(fetchRequest).first,
              let persons = department.persons?.allObjects as? [Person]
        else { throw DemoError.unexpected }

        print(persons.allSatisfy { $0.isFault })

        let person = persons[0]

        print(person.isFault)

        person.printDescription()

        print(person.isFault)
    }

    private func prepareData() {
        coreDataStack.performTaskOnMainQueueContextAndSave { context in
            let dataGenerator = DataGenerator()
            dataGenerator.clearData(context)
            dataGenerator.generateData(context)
        }
    }
}

// MARK: - Demo NSFetchedResultsController

extension Demo: DemoFetchedResultsController {

    var personsFetchRequest: NSFetchRequest<Person> {
        let fetchRequest = Person.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: #keyPath(Person.position), ascending: true),
            NSSortDescriptor(key: #keyPath(Person.salary), ascending: true)
        ]
        return fetchRequest
    }

    func demoFetchedResultsController() {
        coreDataStack.performTaskOnMainQueueContextAndSave { [weak self] context in
            guard let self = self else { return }
            do {
                try self.updateData(context)
//                try self.moveData(context)
//                try self.insertData(context)
//                try self.deleteData(context)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    private func updateData(_ context: NSManagedObjectContext) throws {
        let persons = try context.fetch(personsFetchRequest)
        persons[0].salary = 1200
    }

    private func moveData(_ context: NSManagedObjectContext) throws {
        let persons = try context.fetch(personsFetchRequest)
        persons[2].salary = 3000
    }

    private func insertData(_ context: NSManagedObjectContext) throws {
        guard let newPerson = NSEntityDescription.insertNewObject(
            forEntityName: "Person",
            into: context
        ) as? Person else { throw DemoError.unexpected }
        
        newPerson.position = "Backend developer"
        newPerson.salary = 2100
        
        let departmentFetchRequest = Department.fetchRequest()
        guard let department = try context.fetch(departmentFetchRequest).first else {
            throw DemoError.unexpected
        }
        
        department.addToPersons(newPerson)
    }

    private func deleteData(_ context: NSManagedObjectContext) throws {
        let persons = try context.fetch(personsFetchRequest)
        context.delete(persons[1])
    }

}

// MARK: - Error

enum DemoError: Error {
    case unexpected
}
