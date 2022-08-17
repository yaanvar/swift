//
//  Interactor.swift
//  VIPER
//
//  Created by Anvar Rahimov on 17.08.2022.
//

import Foundation

// Object
// Protocol
// Reference to presenter

// API - https://jsonplaceholder.typicode.com/users

protocol AnyInteractor {
    var presenter: AnyPresenter? { get set }
    
    func getUsers()
}

class UserInteractor: AnyInteractor {
    var presenter: AnyPresenter?
    
    func getUsers() {
        print("start fetching")
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                
                self?.presenter?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                
                return
            }
            
            do {
                let entities = try JSONDecoder().decode([User].self, from: data)
                
                self?.presenter?.interactorDidFetchUsers(with: .success(entities))
            } catch {
                self?.presenter?.interactorDidFetchUsers(with: .failure(error))
            }
        }
        
        task.resume()
    }
}
