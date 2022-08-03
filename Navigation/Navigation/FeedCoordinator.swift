//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Илья on 08.06.2022.
//

import Foundation
import UIKit

protocol FeedCoordinator {
    func openPostViewController()
    func openInfoViewController()
    func openImagesUserTabBarController()
}


final class FeedCoordinatorImplementation: FeedCoordinator {
    
    var navigationController: UINavigationController
    weak var presenter: UIViewController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    convenience init(presenter: UIViewController, navigationController: UINavigationController) {
        self.init(navigationController: navigationController)
        self.presenter = presenter
    }
    
    func openPostViewController() {
        print("TAP -> Открывается окно post")
        let postViewController = PostViewController()
        let titlePost: Post = Post(title: "Post")
        postViewController.title = titlePost.title
        self.navigationController.pushViewController(postViewController, animated: true)
    }
    
    func openInfoViewController() {
        print("TAP -> Открывается окно info")
        let infoViewController = InfoViewController()
        let infoNavigationController = UINavigationController(rootViewController: infoViewController)
        presenter?.present(infoNavigationController, animated: true)
    }
    
    func openImagesUserTabBarController() {
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
        
        let imagesUserCoordinator = UserImagesCoordinatorImplementation()
        let imagesUserTabBarController = ImagesUserTabBarController(coordinator: imagesUserCoordinator, viewControllers: [imagesNavigationController, settingsNavigationController])
        
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        appDelegate.window?.rootViewController = imagesUserTabBarController
        appDelegate.window?.makeKeyAndVisible()
    }
}
