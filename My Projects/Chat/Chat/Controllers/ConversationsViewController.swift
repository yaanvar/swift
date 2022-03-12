//
//  ConversationsViewController.swift
//  Chat
//
//  Created by Anvar Rahimov on 12.03.2022.
//

import UIKit

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "loggedIn")
        
        if !isLoggedIn {
            let viewController = LoginViewController()
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.modalPresentationStyle = .fullScreen
            navigationController.navigationBar.prefersLargeTitles = true
            present(navigationController, animated: false)
        }
    }


}

