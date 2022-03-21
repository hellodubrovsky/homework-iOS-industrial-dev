//
//  PublicationModel.swift
//  Navigation
//
//  Created by Илья on 11.01.2022.
//

import Foundation
import UIKit

// MARK: - Модель публикации постов.

struct PostUsers {
    var author: String
    var description: String
    var image: UIImage
    var likes: Int
    var views: Int
    
    init(author: String, description: String, image: UIImage, likes: Int, views: Int) {
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views
    }
}

let posts: [PostUsers] = [
    PostUsers(author: "Hiscory cinema",
              description: "The adventures of Shurik, this is a great movie that can be constantly reviewed. And that's great.",
              image: UIImage(named: "iconPost-1")!,
              likes: 551 ,
              views: 100),
    
    PostUsers(author: "Adventures and interesting stories.",
              description: "The adventures of Shurik, this is a great movie that can be constantly reviewed. And that's great.",
              image: UIImage(named: "iconPost-2")!,
              likes: 23 ,
              views: 441),
    
    PostUsers(author: "Space flights, interesting stories of Soviet cosmonauts. When are we going to Mars?",
              description: "The adventures of Shurik, this is a great movie that can be constantly reviewed. And that's great.", //The adventures of Shurik, this is a great movie that can be constantly reviewed. And that's great.",
              image: UIImage(named: "iconPost-3")!,
              likes: 666 ,
              views: 1),
    
    PostUsers(author: "Space flights, interesting stories of Soviet cosmonauts. When are we going to Mars? Space flights.",
              description: "The adventures of Shurik, this is a great movie that can be constantly reviewed. And that's great.",
              image: UIImage(named: "iconPost-4")!,
              likes: 1 ,
              views: 888),
]
