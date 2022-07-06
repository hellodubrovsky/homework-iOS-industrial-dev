//
//  Enums.swift
//  Navigation
//
//  Created by Илья on 08.06.2022.
//

import Foundation

enum ResultCheckPassword {
    case empty
    case correct
    case incorrect 
}


// MARK: - MusicPlayer

enum ChangeCounterMusic {
    case forward
    case backward
}

enum StatePlayer {
    case play
    case pause
}


// MARK: - NetworkService

enum AppConfiguration: String, CaseIterable {
    case people = "https://swapi.dev/api/people/8"
    case planets = "https://swapi.dev/api/planets/5"
    case starships = "https://swapi.dev/api/starships/3"
    case test404 = "https://swapi.dev/api/starships/3333333333"
    case testIncorrect = ""
}
