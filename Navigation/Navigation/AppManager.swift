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
        let brutForceDelegate: AuthorizationBrutForceDelegate = BrutForcePasswordService()
        let authorizationViewController = AuthorizationViewController(coordinator: authorizationViewControllerCoordinator, authorizationDelegate: authorizationDelegate, brutForceDelegate: brutForceDelegate)
        
        // Create tab bar items
        let feedItemTabBar = factory.makeTabBarItem(title: "Feed", image: UIImage(systemName: "house.fill")!)
        let multimediaItemTabBar = factory.makeTabBarItem(title: "Media", image: UIImage(systemName: "music.note.house.fill")!)
        let profileItemTabBar = factory.makeTabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle.fill")!)
        
        // Create navigation controllers
        let feedNavigationController = factory.makeNavigatioController(viewController: feedViewController, taBarItem: feedItemTabBar)
        let mediaNavigationController = factory.makeNavigatioController(viewController: multimediaViewController, taBarItem: multimediaItemTabBar)
        let profileNavigationController = factory.makeNavigatioController(viewController: authorizationViewController, taBarItem: profileItemTabBar)
        
        // Create main tab bar controller
        let rootCoordinator = MainCoordinatorImplementation()
        let rootTabBarViewController = MainTabBarController(coordinator: rootCoordinator, viewControllers: [feedNavigationController, mediaNavigationController, profileNavigationController])
        rootCoordinator.tabBarController = rootTabBarViewController
        rootViewController = rootTabBarViewController.coordinator?.startMainModule() ?? rootTabBarViewController
    }
}
