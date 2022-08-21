//
//  NewsAPI.swift
//  NewNews(SwiftUI)
//
//  Created by Anvar Rahimov on 13.08.2022.
//

import Foundation

protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseUrl: URL { get }
    var apiKey: String { get }
}

enum NewsAPI {
    case getNews
}

extension NewsAPI: APIBuilder {
    var urlRequest: URLRequest {
        return URLRequest(url: self.baseUrl.appendingPathComponent(apiKey))
    }
    
    var baseUrl: URL {
        switch self {
        case .getNews:
            return URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=b956f94fd1c545f8b1e1a43e522db33d")!
            //return URL(string: "https://api.lil.software")!
        }
    }
    
    var apiKey: String {
        return ""
    }
}
