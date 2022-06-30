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
    private let logInFactory: LogInFactory = LogInFactory()
    private let feedPresenter = FeedPresenter()
    private let profileViewController = LogInViewController()
    private let multimediaViewController = MultimediaViewController()
    
    
    
    // MARK: - Private init
    private init() {
        let feedViewController = FeedViewController(presenter: self.feedPresenter)
        profileViewController.delegate = logInFactory.makeLogInInspecctor()
        
        // Create tab bar items
        let feedItemTabBar = factory.makeTabBarItem(title: "Feed", image: UIImage(systemName: "house.fill")!)
        let profileItemTabBar = factory.makeTabBarItem(title: "Profile", image: UIImage(systemName: "person.crop.circle.fill")!)
        let multimediaItemTabBar = factory.makeTabBarItem(title: "Media", image: UIImage(systemName: "music.note.house.fill")!)
        
        // Create navigation controllers
        let feedNavigationController = factory.makeNavigatioController(viewController: feedViewController, taBarItem: feedItemTabBar)
        let profileNavigationController = factory.makeNavigatioController(viewController: profileViewController, taBarItem: profileItemTabBar)
        let mediaNavigationController = factory.makeNavigatioController(viewController: multimediaViewController, taBarItem: multimediaItemTabBar)
        
        // Create main tab bar controller
        let rootCoordinator = MainCoordinatorImplementation()
        let rootTabBarViewController = MainTabBarController(coordinator: rootCoordinator, viewControllers: [feedNavigationController, mediaNavigationController, profileNavigationController])
        rootCoordinator.tabBarController = rootTabBarViewController
        rootViewController = rootTabBarViewController.coordinator?.startMainModule() ?? rootTabBarViewController
    }
}
