//
//  Errors.swift
//  Navigation
//
//  Created by Илья on 26.06.2022.
//

import Foundation

// MARK: Authorization

enum AuthorizationErrors: Error {
    case emptyLofinOrPassword
    case emptyLoginField
    case emptyPassordField
    case incorrectPasswordOrLogin
}
