//
//  KeychainManager .swift
//  Navigation
//
//  Created by Илья on 08.08.2022.
//

import Foundation
import KeychainAccess



protocol KeychainManagerProtocol: AnyObject {
    
    /// Сохранение нового пользователя.
    func addNewUserWith(password: String)
    
    /// Обновление пароля пользователя.
    func updateUsers(password: String)
    
    /// Проверка существования пользователя, и если он возврат пароля.
    func getPassword() -> String?
}



// MARK: - KeychainManager

final class KeychainManager: KeychainManagerProtocol {
    
    // MARK: Static properties
    static var shared: KeychainManager { KeychainManager() }
    
    
    
    // MARK: Private properties
    private let keychain = Keychain(service: "password_on_screen_feed")
    private let nameUser = "user_password_on_screen_feed"
    
    
    
    // MARK: Public methods
    
    func addNewUserWith(password: String) {
        self.keychain[nameUser] = password
    }
    
    func updateUsers(password: String) {
        self.keychain[nameUser] = password
    }
    
    func getPassword() -> String? {
        guard let token = keychain[nameUser] else { return nil }
        print("Token: \(token)")
        return token
    }
}
