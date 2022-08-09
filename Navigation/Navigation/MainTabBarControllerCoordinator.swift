//
//  UserImagesCoordinator.swift
//  Navigation
//
//  Created by Илья on 03.08.2022.
//

import Foundation
import UIKit

protocol MainTabBarControllerCoordinator: AnyObject {
    var tabBarController: UITabBarController? { get set }
    var childCoordinators: [CoordinatorProtocol]? { get set }
}


final class MainTabBarControllerCoordinatorImplementation: MainTabBarControllerCoordinator {
    var tabBarController: UITabBarController?
    var childCoordinators: [CoordinatorProtocol]?
}


protocol CoordinatorProtocol {
    var navigationController: UINavigationController? { get set }
}
