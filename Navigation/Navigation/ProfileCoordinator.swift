//
//  ProfileCoordinator.swift
//  Navigation
//
//  Created by Илья on 09.06.2022.
//

import Foundation
import UIKit

protocol ProfileCoordinator {
    func openProfileScreen()
    func openPhotoUserScreen()
}

final class ProfileCoordinatorImplementation: ProfileCoordinator, CoordinatorProtocol {
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func openProfileScreen() {}
    func openPhotoUserScreen() {}
}
