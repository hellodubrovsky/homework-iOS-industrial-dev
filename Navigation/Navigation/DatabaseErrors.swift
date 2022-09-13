//
//  DatabaseErrors.swift
//  Navigation
//
//  Created by Илья on 23.08.2022.
//

import Foundation

enum DatabaseErrors: Error {
    case wrongModel
    case customError(description: String)
    case unknown
}
