//
//  AppDelegate.swift
//  FRApp
//
//  Created by n.gundorin on 26.03.2022.
//

import UIKit
import CoreData

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let coreDataStack = CoreDataStack()
        let demo = Demo(coreDataStack: coreDataStack)

        // comment for FRC demo
        demo.demoFetchRequest()

        let viewController = assemblePersonsViewController(coreDataStack: coreDataStack,
                                                           demo: demo)

        let window = UIWindow()
        window.rootViewController = viewController
        window.makeKeyAndVisible()

        self.window = window

        return true
    }

    // MARK: - Private

    private func assemblePersonsViewController(coreDataStack: CoreDataStackProtocol,
                                               demo: DemoFetchedResultsController) -> UIViewController? {
        let rootViewController = UIStoryboard(name: "Persons",
                                              bundle: nil)
            .instantiateInitialViewController() as? UINavigationController

        let viewController = rootViewController?.topViewController as? PersonsViewController

        viewController?.coreDataStack = coreDataStack
        viewController?.demo = demo

        return viewController
    }
}
