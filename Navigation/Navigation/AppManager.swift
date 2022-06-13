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
    
    
    
    // MARK: - Private init
    private init() {
        let feedViewController = FeedViewController(presenter: self.feedPresenter)
        profileViewController.delegate = logInFactory.makeLogInInspecctor()
        let feedItemTabBar = factory.makeTabBarItem(title: "Feed", image: UIImage(systemName: "house.fill")!)
        let profileItemTabBar = factory.makeTabBarItem(title: "Profile", image: UIImage(systemName: "person.fill")!)
        let feedNavigationController = factory.makeNavigatioController(viewController: feedViewController, taBarItem: feedItemTabBar)
        let profileNavigationController = factory.makeNavigatioController(viewController: profileViewController, taBarItem: profileItemTabBar)
        let rootCoordinator = MainCoordinatorImplementation()
        let rootTabBarViewController = MainTabBarController(coordinator: rootCoordinator, viewControllers: [feedNavigationController, profileNavigationController])
        rootCoordinator.tabBarController = rootTabBarViewController
        rootViewController = rootTabBarViewController.coordinator?.startMainModule() ?? rootTabBarViewController
    }
}
