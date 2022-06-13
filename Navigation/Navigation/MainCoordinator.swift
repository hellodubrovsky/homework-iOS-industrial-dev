//
//  MainCoordinator.swift
//  Navigation
//
//  Created by Илья on 08.06.2022.
//

import Foundation
import UIKit



// MARK: - MainCoordinatorProtocol

protocol MainCoordinator: AnyObject {
    var tabBarController: UITabBarController? { get set }
    var childCoordinators: [CoordinatorProtocol]? { get set }
    func startMainModule() -> UITabBarController
}



// MARK: - MainCoordinator

final class MainCoordinatorImplementation: MainCoordinator {
    
    var tabBarController: UITabBarController?
    var childCoordinators: [CoordinatorProtocol]?
    
    func startMainModule() -> UITabBarController {
        guard let tabBarController = tabBarController else { return MainTabBarController(coordinator: self, viewControllers: [])}
        return tabBarController
    }
}
