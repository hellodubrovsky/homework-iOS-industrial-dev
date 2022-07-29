//
//  LogInInspector.swift
//  Navigation
//
//  Created by Илья on 18.07.2022.
//

import Foundation

final class LogInInspector: AuthorizationCheckerDelegate {
    
    // Проверка существующего пользователя.
    func checkCredentials(login: String, password: String, completion: @escaping (Result<AuthorizationModel, Error>) -> Void) {
        Checker.shared.checkCredentials(login: login, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                let user = AuthorizationModel(email: (result?.user.email)!, UID: (result?.user.uid)!)
                completion(.success(user))
            }
        }
    }
    
    // Регистрация нового пользователя.
    func signUp(login: String, password: String, completion: @escaping (Result<AuthorizationModel, Error>) -> Void) {
        Checker.shared.signUp(login: login, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                let user = AuthorizationModel(email: (result?.user.email)!, UID: (result?.user.uid)!)
                completion(.success(user))
            }
        }
    }
}
