//
//  MARK: Применение паттерна - Factory
//  https://netology.ru/profile/program/iosint-17/lessons/152284/lesson_items/789109
//
//  Created by Илья on 07.04.2022.
//

import Foundation
import UIKit

final class AppFactory {
    
    func makeRootTabBarViewController(viewControllers: [UIViewController]) -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = viewControllers
        tabBarController.selectedViewController = viewControllers.first
        tabBarController.tabBar.tintColor = UIColor.init(named: "colorBaseVK")
        tabBarController.tabBar.unselectedItemTintColor = .black
        let backgroundColor = UIColor(red: CGFloat(238.0 / 255.0), green: CGFloat(238.0 / 255.0), blue: CGFloat(238.0 / 255.0), alpha: CGFloat(1.0))
        tabBarController.tabBar.backgroundColor = backgroundColor
        return tabBarController
    }
    
    func makeNavigatioController(viewController: UIViewController, taBarItem: UITabBarItem) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = taBarItem
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.init(named: "colorBaseVK")
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        return navigationController
    }
    
    func makeTabBarItem(title: String, image: UIImage) -> UITabBarItem {
        let itemTabBar = UITabBarItem()
        itemTabBar.title = title
        itemTabBar.image = image
        return itemTabBar
    }
}
