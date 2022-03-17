//
//  ProfileViewController.swift
//  MicroBlog
//
//  Created by Anvar Rahimov on 17.03.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: - Overriden

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(signOutTapped))
    }
    
    //MARK: - Functions
    
    @objc func signOutTapped() {
         
    }

}
