//
//  CheckStartScreenCoordinator.swift
//  Documents
//
//  Created by Илья on 09.08.2022.
//

import Foundation
import UIKit

protocol CheckStartScreenCoordinator {
    func openImagesUserTabBarController()
}


final class CheckStartScreenCoordinatorImplementation: CheckStartScreenCoordinator {
    
    var navigationController: UINavigationController
    weak var presenter: UIViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    convenience init(presenter: UIViewController, navigationController: UINavigationController) {
        self.init(navigationController: navigationController)
        self.presenter = presenter
    }
    
    func openImagesUserTabBarController() {
        print("Должно произойти открытие tabBarController")
        
        let imagesViewController = ImagesUserViewController()
        let imagesNavigationController = UINavigationController(rootViewController: imagesViewController)
        let imagesTabBarItem = UITabBarItem()
        imagesTabBarItem.title = "Images"
        imagesTabBarItem.image = UIImage(systemName: "photo.circle.fill")
        imagesNavigationController.tabBarItem = imagesTabBarItem
        
        let settingsViewController = SettingsViewController()
        let settingsNavigationController = UINavigationController(rootViewController: settingsViewController)
        let settingsTabBarItem = UITabBarItem()
        settingsTabBarItem.title = "Settings"
        settingsTabBarItem.image = UIImage(systemName: "gear")
        settingsNavigationController.tabBarItem = settingsTabBarItem
        
        let mainTabBarCoordinator = MainTabBarControllerCoordinatorImplementation()
        let mainTabBarController = MainTabBarController(coordinator: mainTabBarCoordinator, viewControllers: [imagesNavigationController, settingsNavigationController])
        
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        appDelegate.window?.rootViewController = mainTabBarController
        appDelegate.window?.makeKeyAndVisible()
    }
}
