//
//  Post.swift
//  MicroBlog
//
//  Created by Anvar Rahimov on 18.03.2022.
//

import Foundation

struct Post {
    let title: String
    let timestamp: TimeInterval
    let headerImageURL: URL?
    let text: String
    let identifier: String
}
