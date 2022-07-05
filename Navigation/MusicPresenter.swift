//
//  MusicPresenter.swift
//  Navigation
//
//  Created by Илья on 30.06.2022.
//

import Foundation
import UIKit


// MARK: - MusicPresenterDelegate

protocol MusicPresenterDelegate: AnyObject {
    func presentList(songs: [MusicModel])
}

typealias PresenterDelegate = MusicPresenterDelegate & UIViewController





// MARK: - MusicPresenter

final class MusicPresenter {
    
    weak var delegate: PresenterDelegate?
    
    func getSongs() {
        self.delegate?.presentList(songs: MusicModel.songList)
    }
    
    func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
}
