//
//  AppDelegate.swift
//  Documents
//
//  Created by Илья on 09.08.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let checkStartScreenPresenter = CheckStartScreenPresenter()
        let checkStartScreenViewController = CheckStartScreenViewController(presenter: checkStartScreenPresenter)
        window?.rootViewController = checkStartScreenViewController
        window?.makeKeyAndVisible()
        return true
    }
}

