//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Илья on 09.06.2022.
//

import Foundation
import UIKit

protocol ProfileCoordinator {
    func openProfileScreen(service: UserService, userName: String)
    func openPhotoUserScreen()
    func set(navigationController: UINavigationController)
}

final class ProfileCoordinatorImplementation: ProfileCoordinator {
    
    weak var navigationController: UINavigationController?
    
    func set(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func openProfileScreen(service: UserService, userName: String) {
        let viewController = ProfileViewController(userService: service, userName: userName)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func openPhotoUserScreen() {
        let vc = PhotosViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
