//
//  AppDelegate.swift
//  Navigation
//
//  Created by Илья on 26.11.2021.
//  Homework: https://github.com/netology-code/iosui-homeworks/tree/iosui-8/1.3



import UIKit


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // Окно, в котором может быть группа контроллеров. Все iOS приложения одноэкранные.
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Перечисление дочерних контроллеров.
        let feedViewController = FeedViewController()
        let profileViewController = LogInViewController()
        
        // Делаем из наших view контроллеров, новый стек navigationController.
        let feedNavigationController = UINavigationController(rootViewController: feedViewController)
        let profileNavigationController = UINavigationController(rootViewController: profileViewController)
        
        // Создания item'ов в tabBar.
        let itemFeedView = UITabBarItem()
        let itemProfileView = UITabBarItem()
        
        // Добавление к tabBarItem'м заголовков.
        itemFeedView.title = "Feed"
        itemProfileView.title = "Profile"
        
        // Добавление изображения к item'м tabBarController'a.
        itemFeedView.image = UIImage(systemName: "house.fill")
        itemProfileView.image = UIImage(systemName: "person.fill")
        
        // Соединяем item'ы с нужными viewController'ми.
        feedNavigationController.tabBarItem = itemFeedView
        profileNavigationController.tabBarItem = itemProfileView
 
        // Возврат navigationController к реализации до iOS 13
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.init(named: "colorBaseVK")
        feedNavigationController.navigationBar.scrollEdgeAppearance = appearance
        profileNavigationController.navigationBar.scrollEdgeAppearance = appearance
        
        // Создание tabBar и добавление в него, навигационных стеков, и по умолчаниию, выбираем экран с постами.
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [feedNavigationController, profileNavigationController]
        tabBarController.selectedViewController = profileNavigationController//feedNavigationController
        
        // Изменяем дизайн tabBar.
        tabBarController.tabBar.backgroundColor = UIColor(red: CGFloat(238.0 / 255.0), green: CGFloat(238.0 / 255.0), blue: CGFloat(238.0 / 255.0), alpha: CGFloat(1.0))
        
        // Изменение цвета заголовка у активных и неактивных tabBarItem'в.
        tabBarController.tabBar.tintColor = UIColor.init(named: "colorBaseVK")
        tabBarController.tabBar.unselectedItemTintColor = .black
        
        // Делаем tabBar ключевым в нашем окне.
        window = UIWindow()
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }
}
