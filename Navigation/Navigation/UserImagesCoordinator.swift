//
//  UserImagesCoordinator.swift
//  Navigation
//
//  Created by Илья on 03.08.2022.
//

import Foundation
import UIKit

protocol UserImagesCoordinator: AnyObject {
    var tabBarController: UITabBarController? { get set }
    var childCoordinators: [CoordinatorProtocol]? { get set }
}


final class UserImagesCoordinatorImplementation: UserImagesCoordinator {
    var tabBarController: UITabBarController?
    var childCoordinators: [CoordinatorProtocol]?
}
