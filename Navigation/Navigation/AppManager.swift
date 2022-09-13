//
//  MARK: Применение паттерна - Singleton
//  https://netology.ru/profile/program/iosint-17/lessons/152284/lesson_items/789109
//  https://medium.com/@nimjea/singleton-class-in-swift-17eef2d01d88
//
//  Created by Илья on 07.04.2022.
//

import Foundation
import UIKit

final class AppManager {
    
    // MARK: - Static properties
    static var shared: AppManager { AppManager() }
    
    
    
    // MARK: - Public properties
    let rootViewController: UITabBarController
    
    
    
    // MARK: - Private properties
    private let factory: AppFactory = AppFactory()
    
   
    
    
    
    // MARK: - Private init
    private init() {
        
        // Feed
        let feedPresenter = FeedPresenter()
        let feedViewController = FeedViewController(presenter: feedPresenter)
        
        // Multimedia
        let multimediaViewController = MultimediaViewController()
        
        // Autorization
        let authorizationViewControllerCoordinator = ProfileCoordinatorImplementation()
        let authorizationDelegate: AuthorizationCheckerDelegate = LogInInspector()
        let authorizationViewController = AuthorizationViewController(coordinator: authorizationViewControllerCoordinator, authorizationDelegate: authorizationDelegate)
        
        // Adding photos
        let imagePickerViewController = ImagePickerViewController()
        
        // Favorite posts
        let favoritePostsViewController = FavoritePostsViewController()
        
        // Create tab bar items
        let feedItemTabBar = factory.makeTabBarItem(title: "Feed", image: UIImage(systemName: "house.fill")!)
        let multimediaItemTabBar = factory.makeTabBarItem(title: "Media", image: UIImage(systemName: "music.note.house.fill")!)
        let profileItemTabBar = factory.makeTabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle.fill")!)
        let imagePickerTabBar = factory.makeTabBarItem(title: "Add photo", image: UIImage(systemName: "plus.circle.fill")!)
        let favoritePostsTabBar = factory.makeTabBarItem(title: "Favorite posts", image: UIImage(systemName: "star.circle.fill")!)
        
        // Create navigation controllers
        let feedNavigationController = factory.makeNavigatioController(viewController: feedViewController, taBarItem: feedItemTabBar)
        let mediaNavigationController = factory.makeNavigatioController(viewController: multimediaViewController, taBarItem: multimediaItemTabBar)
        let profileNavigationController = factory.makeNavigatioController(viewController: authorizationViewController, taBarItem: profileItemTabBar)
        let favoritePostsNavigationController = factory.makeNavigatioController(viewController: favoritePostsViewController, taBarItem: favoritePostsTabBar)
        imagePickerViewController.tabBarItem = imagePickerTabBar
        
        // Create main tab bar controller
        let rootCoordinator = MainCoordinatorImplementation()
        let rootTabBarViewController = MainTabBarController(coordinator: rootCoordinator, viewControllers: [feedNavigationController, mediaNavigationController, imagePickerViewController, favoritePostsNavigationController ,profileNavigationController])
        rootCoordinator.tabBarController = rootTabBarViewController
        rootViewController = rootTabBarViewController.coordinator?.startMainModule() ?? rootTabBarViewController
    }
}
