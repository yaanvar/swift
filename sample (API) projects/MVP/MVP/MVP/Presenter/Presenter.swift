//
//  Presenter.swift
//  MVP
//
//  Created by Anvar Rahimov on 17.08.2022.
//

import Foundation
import UIKit

// API - https://jsonplaceholder.typicode.com/users

typealias PresenterDelegate = UserPresenterDelegate & UIViewController

protocol UserPresenterDelegate: AnyObject {
    func presentUsers(users: [User])
    func presentAlert(title: String, message: String)
}

class UserPresenter {
    
    weak var delegate: PresenterDelegate?
    
    func getUsers() {
        print("start fetching")
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                self?.delegate?.presentUsers(users: users)
            } catch {
                self?.delegate?.presentAlert(title: "Error Occured", message: error.localizedDescription)
            }
        }
        
        task.resume()
    }
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    public func didTap(user: User) {
        delegate?.presentAlert(title: user.name,
                               message: "\(user.name) has an email of \(user.email) and username of \(user.username)")
    }
}
