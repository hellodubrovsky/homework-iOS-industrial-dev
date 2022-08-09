//
//  FeedModel.swift
//  Navigation
//
//  Created by Илья on 15.05.2022.
//

import Foundation

final class FeedModel {
    var password: String? = KeychainManager.shared.getPassword()
}
