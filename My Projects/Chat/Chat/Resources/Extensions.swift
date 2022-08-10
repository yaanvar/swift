//
//  Extensions.swift
//  Chat
//
//  Created by Anvar Rahimov on 13.03.2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showSignInViewController(withAnimation: Bool = false) {
        let viewController = SignInViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.navigationBar.prefersLargeTitles = true
        present(navigationController, animated: withAnimation)
    }
    
}
