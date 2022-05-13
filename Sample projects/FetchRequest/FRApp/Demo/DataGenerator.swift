//
//  DataGenerator.swift
//  FRApp
//
//  Created by n.gundorin on 27.03.2022.
//

import Foundation
import CoreData
import UIKit

final class DataGenerator {

    // MARK: Public

    func generateData(_ context: NSManagedObjectContext) {
        let persons: [(salary: Decimal, position: String)] = [
            (salary: 2000, position: "iOS developer"),
            (salary: 1500, position: "Android developer"),
            (salary: 1000, position: "Android developer"),
            (salary: 2500, position: "iOS developer")
        ]

        let department = createDepartment(name: "Main", into: context)

        persons.forEach {
            createPerson(salary: $0.salary,
                         position: $0.position,
                         department: department,
                         into: context)
        }
    }

    func clearData(_ context: NSManagedObjectContext) {
        do {
            let request = Department.fetchRequest()
            let departments = try context.fetch(request)
            departments.forEach {
                context.delete($0)
            }
        } catch {
            fatalError()
        }
    }

    // MARK: Private

    private func createDepartment(
        name: String,
        into context: NSManagedObjectContext
    ) -> Department {
        guard let department = NSEntityDescription.insertNewObject(
            forEntityName: "Department",
            into: context
        ) as? Department else { fatalError() }

        department.name = name
        return department
    }

    private func createPerson(
        salary: Decimal,
        position: String,
        department: Department,
        into context: NSManagedObjectContext
    ) {
        guard let person = NSEntityDescription.insertNewObject(
            forEntityName: "Person",
            into: context
        ) as? Person else { fatalError() }

        person.salary = salary as NSDecimalNumber
        person.position = position
        department.addToPersons(person)
    }
}
