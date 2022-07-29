//
//  MARK: Паттерн Singleton
//  CheckerAuthorizations.swift
//  Navigation
//
//  Created by Илья on 07.04.2022.
//

import Foundation
import FirebaseAuth



protocol CheckerServiceProtocol: AnyObject {
    func checkCredentials(login: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void)
    func signUp(login: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void)
}



final class Checker: CheckerServiceProtocol {
    
    // MARK: - Static properties
    static var shared: Checker { Checker() }
    
    
    
    // MARK: - Private properties
    private let login = "login"
    private let password = "pas"
    
    
    
    // MARK: - Public methods
    func check(login: String, password: String) -> Bool {
        login == self.login && password == self.password
    }

    func refundPassword() -> String { self.password }
    
    
    func checkCredentials(login: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().signIn(withEmail: login, password: password) { result, error in
            if let error = error {
                completion(nil, error)
            } else {
                print("User sings in successfully.")
                completion(result, nil)
            }
        }
    }
    
    func signUp(login: String, password: String, completion: @escaping (AuthDataResult?, Error?) -> Void) {
        Auth.auth().createUser(withEmail: login, password: password) { result, error in
            if let error = error {
                completion(nil, error)
            } else {
                print("User sings up successfully.")
                completion(result, nil)
            }
        }
    }
}
