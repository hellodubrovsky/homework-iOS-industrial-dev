//
//  MusicModel.swift
//  Navigation
//
//  Created by Илья on 30.06.2022.
//

import Foundation
import UIKit


struct MusicModel {
    var name: String
    var artist: String
    var image: UIImage?
    var filePath: URL
}

extension MusicModel {
    static var songList: [MusicModel] = [MusicModel(name: "Дежавю", artist: "kizaru", image: UIImage(named: "music2"), filePath: Bundle.main.url(forResource: "music1", withExtension: "mp3")!),
                                         MusicModel(name: "PUSSY BOY", artist: "Egor Creed", image: UIImage(named: "music1"), filePath: Bundle.main.url(forResource: "music2", withExtension: "mp3")!),
                                         MusicModel(name: "Frendli fire", artist: "Boulevar Depo", image: UIImage(named: "music3"), filePath: Bundle.main.url(forResource: "music3", withExtension: "mp3")!),
                                         MusicModel(name: "Поворот", artist: "Машина Времени", image: nil, filePath: Bundle.main.url(forResource: "music4", withExtension: "mp3")!),
                                         MusicModel(name: "Мой друг", artist: "Машина Времени", image: UIImage(named: "music5"), filePath: Bundle.main.url(forResource: "music5", withExtension: "mp3")!),
                                         MusicModel(name: "Кто тебе сказал?", artist: "hellodubrovsky", image: UIImage(named: "music6"), filePath: Bundle.main.url(forResource: "music6", withExtension: "mp3")!),
                                         MusicModel(name: "ПАПА ПСИХ", artist: "МС Гена Букин", image: UIImage(named: "music7"), filePath: Bundle.main.url(forResource: "music7", withExtension: "mp3")!)]
}

