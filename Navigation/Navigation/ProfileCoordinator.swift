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
}

final class ProfileCoordinatorImplementation: ProfileCoordinator, CoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func openProfileScreen(service: UserService, userName: String) {
        print("TAP -> Открывается окно profile.")
        let viewController = ProfileViewController(userService: service, userName: userName)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func openPhotoUserScreen() {
        print("TAP -> Открывается окно с фотографиями профиля.")
        let vc = PhotosViewController()
        navigationController.pushViewController(vc, animated: true)
    }
}
