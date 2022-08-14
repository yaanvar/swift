//
//  News.swift
//  NewNews(SwiftUI)
//
//  Created by Anvar Rahimov on 13.08.2022.
//

import Foundation

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}
