//
//  AuthorizationModel.swift
//  Navigation
//
//  Created by Илья on 29.07.2022.
//

import Foundation

struct AuthorizationModel {
    var login: String
    var password: String?
    var uid: String
    var authorizationStatus: Bool = false
    
    var keyedValues: [String: Any] {
        return [
            "login": self.login,
            "password": self.password ?? "",
            "uid": self.uid,
            "authorizationStatus": self.authorizationStatus
        ]
    }
}
