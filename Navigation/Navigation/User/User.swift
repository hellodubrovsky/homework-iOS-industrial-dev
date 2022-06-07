//
//  User.swift
//  Navigation
//
//  Created by Илья on 31.03.2022.
//

import Foundation
import UIKit

class User {
    var name: String
    var status: String?
    var image: UIImage?
    
    init(name: String) {
        self.name = name
    }
    
    init(name: String, status: String, image: UIImage) {
        self.name = name
        self.status = status
        self.image = image
    }
}
