//
//  AppDelegate.swift
//  Navigation
//
//  Created by Илья on 26.11.2021.
//  Homework: https://github.com/netology-code/iosui-homeworks/tree/iosui-8/1.3



import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.rootViewController = AppManager.shared.rootViewController
        window?.makeKeyAndVisible()
        NetworkService.launchingTheURLSessionDataTask(by: AppConfiguration.allCases.randomElement()?.rawValue ?? AppConfiguration.people.rawValue)
        return true
    }
}
