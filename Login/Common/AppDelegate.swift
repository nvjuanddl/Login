//
//  AppDelegate.swift
//  Login
//
//  Created by Juan Delgado Lasso on 23/11/23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let viewController = MainWireframe().viewController
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        window?.rootViewController = viewController
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        return true
    }
}

