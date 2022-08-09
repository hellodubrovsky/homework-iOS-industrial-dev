//
//  CheckStartScreenModel.swift
//  Documents
//
//  Created by Илья on 09.08.2022.
//

import Foundation

final class CheckStartScreenModel {
    var password: String? = KeychainManager.shared.getPassword()
}
