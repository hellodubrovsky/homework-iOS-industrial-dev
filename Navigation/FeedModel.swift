//
//  FeedModel.swift
//  Navigation
//
//  Created by Илья on 15.05.2022.
//

import Foundation

final class FeedModel {
    
    static var shared: FeedModel { FeedModel() }
    private let password: String = "1"
    
    func check(word: String) {
        let notificationCenter = NotificationCenter.default
        if word == "" {
            notificationCenter.post(name: Notification.Name("emptyPassword"), object: nil)
        } else if word == password {
            notificationCenter.post(name: Notification.Name("correctPassword"), object: nil)
        } else {
            notificationCenter.post(name: Notification.Name("incorrectPassword"), object: nil)
        }
    }
}
