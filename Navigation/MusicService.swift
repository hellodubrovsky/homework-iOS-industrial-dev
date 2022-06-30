//
//  MusicService.swift
//  Navigation
//
//  Created by Илья on 30.06.2022.
//

import UIKit

final class MusicService {
    
    func getListSong() -> [MusicModel] {
        let songList: [MusicModel] = [MusicModel(name: "Pussy boy", artist: "Egor Creed", album: "Pyssy boy", image: nil, filePath: Bundle.main.url(forResource: "music1", withExtension: "mp3")!),
                                      MusicModel(name: "Дежавю", artist: "kizaru", album: "Karmagedonn", image: nil, filePath: Bundle.main.url(forResource: "music2", withExtension: "mp3")!),
                                      MusicModel(name: "Frendli fire", artist: "Boulevar Depo", album: "Old Blood", image: nil, filePath: Bundle.main.url(forResource: "music3", withExtension: "mp3")!),
                                      MusicModel(name: "Поворот", artist: "Машина Времени", album: "Счастье", image: nil, filePath: Bundle.main.url(forResource: "music4", withExtension: "mp3")!),
                                      MusicModel(name: "Мой друг", artist: "Машина Времени", album: "Счастье", image: nil, filePath: Bundle.main.url(forResource: "music5", withExtension: "mp3")!)]
        return songList
    }
}
