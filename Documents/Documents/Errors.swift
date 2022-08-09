//
//  Errors.swift
//  Documents
//
//  Created by Илья on 09.08.2022.
//

import Foundation

// MARK: Authorization for Post

enum CheckPasswordPostErrors: Error {
    case unowned
    case incorrectSymbols
    case invalidPassword
    case invalidVerificationPassword
}

enum ResultCheckPassword {
    case empty
    case correct
    case incorrect
}
