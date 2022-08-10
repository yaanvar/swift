//
//  TabBarViewController.swift
//  MicroBlog
//
//  Created by Anvar Rahimov on 17.03.2022.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    //MARK: - Overriden

    override func viewDidLoad() {
        super.viewDidLoad()

        setControllers()
    }
    
    //MARK: - Settings
    
    func setControllers() {
        let microBlog = MicroBlogViewController()
        let profile = ProfileViewController()
        
        microBlog.title = "Micro Blog"
        profile.title = "Profile"
        
        let navigationControllerMicroBlog = UINavigationController(rootViewController: microBlog)
        let navigationControllerProfile = UINavigationController(rootViewController: profile)
        
        microBlog.navigationItem.largeTitleDisplayMode = .always
        profile.navigationItem.largeTitleDisplayMode = .always
        navigationControllerMicroBlog.navigationBar.prefersLargeTitles = true
        navigationControllerProfile.navigationBar.prefersLargeTitles = true
        
        navigationControllerMicroBlog.tabBarItem = UITabBarItem(title: "Blog",
                                                                image: UIImage(systemName: "newspaper.fill"),
                                                                tag: 1)
        navigationControllerProfile.tabBarItem = UITabBarItem(title: "Profile",
                                                              image: UIImage(systemName: "person.circle.fill"),
                                                              tag: 2)
        
        setViewControllers([navigationControllerMicroBlog, navigationControllerProfile], animated: true)
    }

}
