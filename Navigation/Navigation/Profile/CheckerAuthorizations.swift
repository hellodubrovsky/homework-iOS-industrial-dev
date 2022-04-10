//
//  MARK: Паттерн Singleton
//  CheckerAuthorizations.swift
//  Navigation
//
//  Created by Илья on 07.04.2022.
//

import Foundation

final class Checker {
    
    // MARK: - Static properties
    static var shared: Checker { Checker() }
    
    
    
    // MARK: - Private properties
    private let login = "login"
    private let password = "pass"
    
    
    
    // MARK: - Public methods
    func check(login: String, password: String) -> Bool {
        guard (login == self.login) && (password == self.password) else { return false }
        return true
    }
}
