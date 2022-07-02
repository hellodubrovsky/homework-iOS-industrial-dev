//
//  MusicViewController.swift
//  Navigation
//
//  Created by Илья on 29.06.2022.
//

import UIKit
import AVFoundation


final class MusicViewController: UIViewController {
    
    // MARK: Private properties
    private let mainView = MusicView()
    private let presenter = MusicPresenter()
    private var songs = [MusicModel]()
    private var counter = 0
    private var audioPlayer: AVAudioPlayer!
    
    
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
        presenter.getSongs()
        mainView.setViewDelegate(delegate: self)
        setView()
    }
    
    
    
    // MARK: Private methods
    
    /// Настройка музыкального плеера
    private func setupAudioPlayer(url: URL) {
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url)
            setupAudioSession()
        } catch {
            ()
        }
    }
    
    /// Настройка аудио-сессии музыкального плеера
    private func setupAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback)
        } catch {
            ()
        }
    }
    
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
        setupAudioPlayer(url: self.songs[self.counter].filePath)
    }
}





// MARK: - MusicPresenterDelegate

extension MusicViewController: MusicPresenterDelegate {
    func presentList(songs: [MusicModel]) {
        self.songs = songs
    }
}





// MARK: - MusicViewDelegate

extension MusicViewController: MusicViewDelegate {
        
    /// Обработка нажатия на кнопку "предыдущая серия"
    func nextButtonAction() {
        changeCounter(to: .forward)
        if audioPlayer.isPlaying {
            setupAudioPlayer(url: self.songs[self.counter].filePath)
            audioPlayer.play()
        } else {
            audioPlayer.stop()
            setupAudioPlayer(url: self.songs[self.counter].filePath)
        }
        mainView.updateView()
    }
    
    /// Обработка нажатия на кнопку "следующая песня"
    func previousButtonAction() {
        changeCounter(to: .backward)
        if audioPlayer.isPlaying {
            setupAudioPlayer(url: self.songs[self.counter].filePath)
            audioPlayer.play()
        } else {
            audioPlayer.stop()
            setupAudioPlayer(url: self.songs[self.counter].filePath)
        }
        mainView.updateView()
    }
    
    /// Обработка нажатия на кнопку play/pause
    func playPauseButtonAction() {
        if audioPlayer.isPlaying {
            audioPlayer.stop()
            mainView.changeStatePlayer(for: .pause)
        } else {
            audioPlayer.play()
            mainView.changeStatePlayer(for: .play)
        }
    }
    
    func getInfoAboutSong() -> (String, String, UIImage?) {
        return (self.songs[self.counter].name, self.songs[self.counter].artist, self.songs[self.counter].image)
    }
}
