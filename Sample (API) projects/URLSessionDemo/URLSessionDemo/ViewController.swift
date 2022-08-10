//
//  ViewController.swift
//  URLSessionDemo
//
//  Created by Anvar Rahimov on 24.06.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let config: URLSessionConfiguration = .default
        //config.allowsCellularAccess = true
        
        let params = [
            "title": "title",
            "body": "body"
        ]
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
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

    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        let session = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("There was an error!")
            } else {
                let jsonRes = try? JSONSerialization.jsonObject(with: data!, options: [])
                print("The response \(jsonRes)")
            }
        }.resume()
    }
}

