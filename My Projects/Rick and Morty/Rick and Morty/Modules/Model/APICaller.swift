//
//  APICaller.swift
//  Rick and Morty
//
//  Created by Anvar Rahimov on 24.04.2022.
//

import Foundation

class APICaller {
    
    static let shared = APICaller()
    
    struct Constants {
        static let allCharacters = URL(string: "https://rickandmortyapi.com/api/character")
    }
    
    private init() {}
    
    public func getAllCharacters(completion: @escaping (Result<[APIResponse], Error>) -> Void) {
        guard let url = Constants.allCharacters else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    
                    print(result.results.count)
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        task.resume()
    }
}

