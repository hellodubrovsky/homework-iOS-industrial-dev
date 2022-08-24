//
//  AuhorizationModelRealm.swift
//  Navigation
//
//  Created by Илья on 23.08.2022.
//

import Foundation
import RealmSwift

final class AuthorizationModelRealm: Object {
    @objc dynamic var login: String = ""
    @objc dynamic var password: String?
    @objc dynamic var uid: String = ""
    @objc dynamic var authorizationStatus: Bool = false
    
    override static func primaryKey() -> String? {
        return "uid"
    }
    
    convenience init(authorizationModel: AuthorizationModel) {
        self.init()
        self.login = authorizationModel.login
        self.password = authorizationModel.password
        self.uid = authorizationModel.uid
        self.authorizationStatus = authorizationModel.authorizationStatus
    }
}
