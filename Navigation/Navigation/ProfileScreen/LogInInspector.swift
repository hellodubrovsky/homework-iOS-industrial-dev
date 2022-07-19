//
//  LogInInspector.swift
//  Navigation
//
//  Created by Илья on 18.07.2022.
//

import Foundation

final class LogInInspector: AuthorizationCheckerDelegate {
    
    /// Метод проверки логина и пароля.
    func check(login: String, password: String, completion: @escaping (Result<Bool, AuthorizationErrors>) -> Void) {
        if login.isEmpty && password.isEmpty {
            completion(.failure(.emptyLofinOrPassword))
        } else if login.isEmpty {
            completion(.failure(.emptyLoginField))
        } else if password.isEmpty {
            completion(.failure(.emptyPassordField))
        } else if !Checker.shared.check(login: login, password: password) {
            completion(.failure(.incorrectPasswordOrLogin))
        } else {
            completion(.success(true))
        }
    }
}
