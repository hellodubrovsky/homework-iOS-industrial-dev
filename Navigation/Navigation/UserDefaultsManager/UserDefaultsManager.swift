//
//  UserDefaultsManager.swift
//  Navigation
//
//  Created by Илья on 05.08.2022.
//

import Foundation

protocol UserDefaultsManagerProtocol: AnyObject {
    
}



final class UserDefaultsManager: UserDefaultsManagerProtocol {
    
    static var shared: UserDefaultsManager { UserDefaultsManager() }
    
}
