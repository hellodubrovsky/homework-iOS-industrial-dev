//
//  PublicationModel.swift
//  Navigation
//
//  Created by Илья on 11.01.2022.
//

import Foundation
import UIKit


// MARK: - Модель публикации постов.

public struct PostUsers {
    public var title: String
    public var description: String
    public var imageName: String
    public var countLikes: UInt
    public var countViews: UInt
    public var isFavorite: Bool
    public let uniqueID: String
    
    /// Создание новой статьи, в которой автоматически генерируется её 'уникальный' ID.
    public init(title: String, description: String, imageName: String, countLikes: UInt, countViews: UInt) {
        self.title = title
        self.description = description
        self.imageName = imageName
        self.countLikes = countLikes
        self.countViews = countViews
        self.isFavorite = false
        self.uniqueID = UUID().uuidString
    }
    
    /// Создание конкретной статьи, у которой уже имеется ID. Использовать только при передачи через другие модели (например при работе с БД).
    public init(title: String, description: String, imageName: String, countLikes: UInt, countViews: UInt, isFavorite: Bool, uniqueID: String) {
        self.title = title
        self.description = description
        self.imageName = imageName
        self.countLikes = countLikes
        self.countViews = countViews
        self.isFavorite = isFavorite
        self.uniqueID = uniqueID
    }
    
    /// Словарь, со значениями постов. Нужен для использования с CoreData.
    public var keyedValue: [String: Any] {
        return [
            "title": self.title,
            "descriptionPost": self.description,
            "imageName": self.imageName,
            "countLikes": self.countLikes,
            "countViews": self.countViews,
            "isFavorite": self.isFavorite,
            "uniqueID": self.uniqueID
        ]
    }
    
}




/// Массив с постами. В данное случае, можно сказать, что это мок-данные.
public var posts: [PostUsers] = [
    PostUsers(title: "Hiscory cinema",
              description: "The adventures of Shurik, this is a great movie that can be constantly reviewed. And that's great.",
              imageName: "iconPost-1",
              countLikes: 551 ,
              countViews: 100),

    PostUsers(title: "Adventures and interesting stories.",
              description: "The adventures of Shurik, this is a great movie that can be constantly reviewed. And that's great.",
              imageName: "iconPost-2",
              countLikes: 23 ,
              countViews: 441),

    PostUsers(title: "Space flights, interesting stories of Soviet cosmonauts. When are we going to Mars?",
              description: "The adventures of Shurik, this is a great movie that can be constantly reviewed. And that's great.",
              imageName: "iconPost-3",
              countLikes: 666 ,
              countViews: 1),

    PostUsers(title: "Space flights, interesting stories of Soviet cosmonauts. When are we going to Mars? Space flights.",
              description: "The adventures of Shurik, this is a great movie that can be constantly reviewed. And that's great.",
              imageName: "iconPost-4",
              countLikes: 1 ,
              countViews: 888),
]
