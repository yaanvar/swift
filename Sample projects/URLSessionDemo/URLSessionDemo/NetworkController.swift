//
//  NetworkController.swift
//  URLSessionDemo
//
//  Created by Anvar Rahimov on 27.06.2022.
//

import Foundation

struct NetworkController {
    static func foo() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }

        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        
        let params = [
            "title": "title",
            "body": "body"
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: params)
        
        let session = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("The error: \(error.localizedDescription)")
            } else {
                let jsonRes = try? JSONSerialization.jsonObject(with: data!)
                print("Response json is: \(jsonRes)")
                
            }
        }.resume()
    }

}
