//
//  AuthorizationCoordinator.swift
//  Navigation
//
//  Created by Илья on 18.07.2022.
//

import Foundation

protocol AuthorizationCoordinator: AnyObject {
    func openProfileScreen(service: UserService, userName: String)
}

final class AuthorizationCoordinatorImplementation {}
