//
//  AppDelegate.swift
//  Weather
//
//  Created by Илья Дубровский on 13.10.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow()
        guard let window = window else { return true }
        window.rootViewController = AccessToLocationViewController()
        window.makeKeyAndVisible()
        return true
    }
}

