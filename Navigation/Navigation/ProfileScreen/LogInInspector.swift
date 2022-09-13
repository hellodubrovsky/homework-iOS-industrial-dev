//
//  LogInInspector.swift
//  Navigation
//
//  Created by Илья on 18.07.2022.
//

import Foundation

final class LogInInspector: AuthorizationCheckerDelegate {
    
    let databaseService = RealmService()
    let userDefaults = UserDefaults.standard
    
    /// Проверка существующего пользователя.
    func checkCredentials(login: String, password: String, completion: @escaping (Result<AuthorizationModel, Error>) -> Void) {
        Checker.shared.checkCredentials(login: login, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                
                // Проверка, имеется ли в UserDefaults сохранненый пользователь.
                if self.userDefaults.string(forKey: "UID") == nil {
                    let userDatabase = AuthorizationModel(login: login, password: password, uid: (result?.user.uid)!, authorizationStatus: true)
                    self.saveUserInDatabase(userDatabase)
                }
                
                let user = AuthorizationModel(login: (result?.user.email)!, uid: (result?.user.uid)!)
                completion(.success(user))
            }
        }
    }
    
    /// Регистрация нового пользователя.
    func signUp(login: String, password: String, completion: @escaping (Result<AuthorizationModel, Error>) -> Void) {
        Checker.shared.signUp(login: login, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                // Сохранение в базу данных нового пользователя.
                let userDatabase = AuthorizationModel(login: login, password: password, uid: (result?.user.uid)!, authorizationStatus: true)
                self.saveUserInDatabase(userDatabase)
                
                let user = AuthorizationModel(login: (result?.user.email)!, uid: (result?.user.uid)!)
                completion(.success(user))
            }
        }
    }
    
    /// Проверка статуса автоматической авторизации.
    func checkingStatusOfAutomaticAuthorization(completion: @escaping (Result<AuthorizationModelRealm, AuthorizationErrors>) -> Void) {
        // Проверка, имеется ли в UserDefaults сохранненая настройка.
        guard self.userDefaults.bool(forKey: "statusAutomaticAuthorization") else {
            completion(.failure(.automaticAuthorizationStatusNotFound))
            return
        }
        // Проверка, имеется ли в UserDefaults сохранненый пользователь.
        guard let userUID = self.userDefaults.string(forKey: "UID") else {
            completion(.failure(.savedUserIsMissing))
            print("\n🤖 The user was not found in the database.")
            return
        }
        let predicate = NSPredicate(format: "uid == %@", userUID)
        self.databaseService.fetch(AuthorizationModelRealm.self, predicate: predicate) { result in
            switch result {
            case .success(let user):
                print("\n🤖 The user was found in the database:\n\(user)")
                completion(.success(user))
            case .failure(let error):
                print(error.localizedDescription)
                print("\n🤖 The user was not found in the database.")
            }
        }
    }
    
    /// Регистрация нового пользователя в БД.
    func saveUserInDatabase(_ user: AuthorizationModel) {
        self.databaseService.create(AuthorizationModelRealm.self, keyedValue: user.keyedValues) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                // Сохранение настройки автоматической авторизации при загрузке контроллера в UserDefaults.
                self.userDefaults.setValuesForKeys(["statusAutomaticAuthorization": true, "UID": user.uid])
                print("\n🤖 A new user has been added to the database:\n\(user)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
