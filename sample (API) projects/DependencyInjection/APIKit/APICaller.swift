//
//  APICaller.swift
//  APIKit
//
//  Created by Anvar Rahimov on 17.08.2022.
//

import Foundation

public class APICaller {
    public static let shared = APICaller()
    
    private init() { }
    
    public func fetchCourseNames(completion: @escaping(([String]) -> Void)) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            completion([])
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion([])
                return
            }
             
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String: String]] else {
                    completion([])
                    return
                }
                
                let names: [String] = json.compactMap({ $0["name"] })
                completion(names)
                
            } catch {
                completion([])
            }
        }
         
        task.resume()
    }
}
