//
//  UserService.swift
//  Navigation
//
//  Created by Илья on 31.03.2022.
//

import Foundation
import UIKit



protocol UserService {
    func searchUserBy(name: String) -> User?
}


// MARK: CurrentUserService.

class CurrentUserService: UserService {
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func searchUserBy(name: String) -> User? {
        guard user.name == name else { return nil }
        return user
    }
}


// MARK: TestUserService. Mock-Data for debug build.

class TestUserService: UserService {
    var user = User(name: "@ALIEN", status: "It's time to start the invasion...", image: UIImage(named: "alienHipster")!)
    
    func searchUserBy(name: String) -> User? {
        return user
    }
}
