//
//  MusicViewController.swift
//  Navigation
//
//  Created by Илья on 29.06.2022.
//

import UIKit


final class MusicViewController: UIViewController {
    
    // MARK: Private properties
    private let mainView = MusicView()
    private let presenter = MusicPresenter()
    private var songs = [MusicModel]()
    private var counter = 0
    
    
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
        presenter.getSongs()
        mainView.setViewDelegate(delegate: self)
        setView()
    }
    
    
    
    // MARK: Private methods
    
    /// Изменение счёчика активной песни в положительную или отрицательную сторону.
    private func changeCounter(to way: ChangeCounterMusic) {
        switch way {
        case .backward:
            if counter == 0 {
                counter = self.songs.count - 1
            } else {
                counter -= 1
            }
        case .forward:
            if (self.songs.count - 1) == counter {
                counter = 0
            } else {
                counter += 1
            }
        }
    }
    
    
    
    // MARK: Setting up the View
    private func setView() {
        // Background gradient
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.init(named: "colorBaseVK")!.cgColor]
        mainView.layer.insertSublayer(gradientLayer, at: 0)
        navigationController?.navigationBar.tintColor = . white
        mainView.backgroundColor = view.backgroundColor
        
        view = mainView
        title = "Music Player"
    }
}





// MARK: - MusicPresenterDelegate

extension MusicViewController: MusicPresenterDelegate {
    
    func presentList(songs: [MusicModel]) {
        self.songs = songs
    }
    
    func buttonAction() {
        mainView.updateView()
    }
}





// MARK: - MusicViewDelegate

extension MusicViewController: MusicViewDelegate {
        
    func nextButtonAction() {
        changeCounter(to: .forward)
        mainView.updateView()
    }
    
    func previousButtonAction() {
        changeCounter(to: .backward)
        mainView.updateView()
    }
    
    func playPauseButtonAction() {
        
    }
    
    func getInfoAboutSong() -> (String, String, UIImage?) {
        return (self.songs[self.counter].name, self.songs[self.counter].artist, self.songs[self.counter].image)
    }
}
