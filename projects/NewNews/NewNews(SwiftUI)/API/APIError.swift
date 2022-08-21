//
//  APIError.swift
//  NewNews(SwiftUI)
//
//  Created by Anvar Rahimov on 13.08.2022.
//

import Foundation

enum APIError: Error {
    case decodingError
    case errorCode(Int)
    case unknownError
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "Failed to decode the object from service"
        case .unknownError:
            return "The error is unknown"
        case .errorCode(let code):
            return "\(code) - something went wrong"
        }
    }
}
