//
//  NSFetchedResultsChangeType+name.swift
//  FRApp
//
//  Created by n.gundorin on 03.04.2022.
//

import CoreData

extension NSFetchedResultsChangeType {

    var name: String {
        switch self {
        case .insert:
            return "insert"

        case .delete:
            return "delete"

        case .move:
            return "move"

        case .update:
            return "update"

        @unknown default:
            return "unknown"
        }
    }
}
