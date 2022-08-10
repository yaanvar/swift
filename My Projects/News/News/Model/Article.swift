//
//  Article.swift
//  News
//
//  Created by Anvar Rahimov on 05.02.2022.
//

import Foundation

struct Article: Codable {
    let title: String
    let description: String
    let url: String
    let urlToImage: String
}
