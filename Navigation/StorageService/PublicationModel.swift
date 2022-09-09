//
//  PublicationModel.swift
//  Navigation
//
//  Created by Илья on 11.01.2022.
//

import Foundation
import UIKit

// MARK: - Создание уникального ID для публикации.

fileprivate func generateUniqueID() -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let length = 12
    return String((0..<length).map { _ in letters.randomElement()! })
}



// MARK: - Модель публикации постов.

public struct PostUsers {
    public var title: String
    public var description: String
    public var image: UIImage?
    public var likes: UInt
    public var views: UInt
    public let uniqueID: String
    
    public init(title: String, description: String, imageName: String, likes: UInt, views: UInt) {
        self.title = title
        self.description = description
        self.image = UIImage(named: imageName) ?? nil
        self.likes = likes
        self.views = views
        self.uniqueID = generateUniqueID()
    }
    
    public init(title: String, description: String, imageName: String, likes: UInt, views: UInt, uniqueID: String) {
        self.title = title
        self.description = description
        self.image = UIImage(named: imageName) ?? nil
        self.likes = likes
        self.views = views
        self.uniqueID = uniqueID
    }
}

public let posts: [PostUsers] = [
    PostUsers(title: "1 Hiscory cinema",
              description: "The adventures of Shurik, this is a great movie that can be constantly reviewed. And that's great.",
              imageName: "iconPost-1",
              likes: 551,
              views: 100),
    PostUsers(title: "1.2 Adventures and interesting stories.",
              description: "The adventures of Shurik, this is a great movie that can be constantly reviewed. And that's great.",
              imageName: "iconPost-2",
              likes: 23,
              views: 441),
    PostUsers(title: "2 Space flights, interesting stories of Soviet cosmonauts. When are we going to Mars?",
              description: "The adventures of Shurik, this is a great movie that can be constantly reviewed. And that's great.", //The adventures of Shurik, this is a great movie that can be constantly reviewed. And that's great.",
              imageName: "iconPost-3",
              likes: 666,
              views: 1),
    PostUsers(title: "2 Space flights, interesting stories of Soviet cosmonauts. When are we going to Mars? Space flights.",
              description: "The adventures of Shurik, this is a great movie that can be constantly reviewed. And that's great.",
              imageName: "iconPost-4",
              likes: 1 ,
              views: 888),
    PostUsers(title: "4 Hiscory cinema",
              description: "The adventures of Shurik, this is a great movie that can be constantly reviewed. And that's great.",
              imageName: "iconPost-1",
              likes: 551 ,
              views: 100),
    PostUsers(title: "5 Adventures and interesting stories.",
              description: "The adventures of Shurik, this is a great movie that can be constantly reviewed. And that's great.",
              imageName: "iconPost-2",
              likes: 23 ,
              views: 441),
    PostUsers(title: "6 Space flights, interesting stories of Soviet cosmonauts. When are we going to Mars?",
              description: "The adventures of Shurik, this is a great movie that can be constantly reviewed. And that's great.", //The adventures of Shurik, this is a great movie that can be constantly reviewed. And that's great.",
              imageName: "iconPost-3",
              likes: 666,
              views: 1),
    PostUsers(title: "7 Space flights, interesting stories of Soviet cosmonauts. When are we going to Mars? Space flights.",
              description: "The adventures of Shurik, this is a great movie that can be constantly reviewed. And that's great.",
              imageName: "iconPost-4",
              likes: 1 ,
              views: 888),
]
