//
//  Errors.swift
//  Navigation
//
//  Created by Илья on 26.06.2022.
//

import Foundation

// MARK: Authorization for Profile

enum AuthorizationErrors: Error {
    case emptyLofinOrPassword
    case emptyLoginField
    case emptyPassordField
    case incorrectPasswordOrLogin
}



// MARK: Authorization for Post

enum CheckPasswordPostErrors: Error {
    case unowned
    case invalidPassword
    case invalidVerificationPassword
}
