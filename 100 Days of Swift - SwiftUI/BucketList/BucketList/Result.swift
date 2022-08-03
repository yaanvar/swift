//
//  Result.swift
//  BucketList
//
//  Created by Anvar Rahimov on 03.08.2022.
//

import Foundation

struct Result: Codable {
    var query: Query
}

struct Query: Codable {
    let pages: [Int: Page]
}

struct Page: Codable, Comparable {
    let pageid: Int
    let title: String
    let terms: [String: [String]]?
}

extension Page {
    var description: String {
        terms?["description"]?.first ?? "No further information."
    }
    
    static func < (lhs: Page, rhs: Page) -> Bool {
        lhs.title < rhs.title
    }
}
