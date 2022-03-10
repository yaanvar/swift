//
//  Commit+CoreDataProperties.swift
//  Project38
//
//  Created by Anvar Rahimov on 10.03.2022.
//
//

import Foundation
import CoreData

extension Commit {
    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Commit> {
        return NSFetchRequest<Commit>(entityName: "Commit")
    }

    @NSManaged public var date: Date
    @NSManaged public var message: String
    @NSManaged public var sha: String
    @NSManaged public var url: String
}
