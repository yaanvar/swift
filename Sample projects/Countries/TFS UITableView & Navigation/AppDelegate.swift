//
//  AppDelegate.swift
//  TFS UITableView & Navigation
//
//  Created by Sergey Shalnov on 28.02.2022.
//

import UIKit

@main
final class AppDelegate: UIResponder {
    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
}

// MARK: - UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window?.rootViewController = UINavigationController(
            rootViewController: RootViewController()
        )
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

