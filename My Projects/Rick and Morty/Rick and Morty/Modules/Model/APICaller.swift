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
        static let allCharactersString = "https://rickandmortyapi.com/api/character"
        static let characterString = "https://rickandmortyapi.com/api/character/"
    }
    
    private init() {}
    
    /// Fetches all characters from API
    public func getAllCharacters(completion: @escaping (Result<([Character]), Error>) -> Void) {
        guard let url = Constants.allCharacters else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success((response.results)))
                } catch {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }
    
    /// Fetches page information from API
    public func getPageInfo(pageURLString: String, completion: @escaping (Result<Info, Error>) -> Void) {
        guard let url = URL(string: pageURLString) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(response.info))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        
        
        task.resume()
    }
    
    /// Fetches page with characters from API with URL
    public func getPageWithCharacters(urlString: String, completion: @escaping (Result<[Character], Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode(APIResponse.self, from: data)

                    completion(.success(response.results))
                } catch {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }
    
    /// Fetches characters by their ID
    public func getCharacterBy(id: Int, completion: @escaping (Result<Character, Error>) -> Void) {
        guard let url = URL(string: Constants.characterString + String(id)) else {
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let response = try JSONDecoder().decode(Character.self, from: data)

                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }
    
}

