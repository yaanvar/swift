//
//  ViewController.swift
//  DependencyInjection
//
//  Created by Anvar Rahimov on 17.08.2022.
//

import UIKit
import MyAppUIKit
import APIKit

extension APICaller: DataFetchable {
    public func fetchUsersNames(completion: @escaping (([String]) -> Void)) {
        
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // https://jsonplaceholder.typicode.com/users
        
        // Button
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 250, height: 50))
        view.addSubview(button)
        button.backgroundColor = .systemBlue
        button.setTitle("tap me!", for: .normal)
        button.center = view.center
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    
        
    }

    @objc private func didTapButton() {
        let viewController = UsersViewController(dataFetchable: APICaller.shared as DataFetchable)
        present(viewController, animated: true)
    }
    
}

