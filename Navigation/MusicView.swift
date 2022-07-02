//
//  MusicView.swift
//  Navigation
//
//  Created by Илья on 30.06.2022.
//

import UIKit
import SnapKit


// MARK: - MusicViewDelegate

protocol MusicViewDelegate: AnyObject {
    func nextButtonAction()
    func previousButtonAction()
    func playPauseButtonAction()
    func getInfoAboutSong() -> (String, String, UIImage?)
}





// MARK: - MusicView

final class MusicView: UIView {
    
    // MARK: Private properties
    private weak var delegate: MusicViewDelegate?

    private var nameSongLabel: UILabel = {
        let label = UILabel()
        label.text = "PUSSY BOY"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var artisSongLabel: UILabel = {
        let label = UILabel()
        label.text = "ЕГОР КРИД"
        label.font = UIFont(name: "HelveticaNeue", size: 20)
        label.textColor = .systemGray5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var imageSongLabel: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.layer.borderColor = UIColor.white.cgColor
        image.layer.borderWidth = 2
        image.layer.shadowColor = UIColor.red.cgColor
        image.layer.shadowRadius = 100
        image.layer.shadowOpacity = 0.8
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var nextSongButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "forward.fill", withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonAction), for: .touchUpInside)
        return button
    }()
    
    private var previousSongButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "backward.fill", withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(previousButtonAction), for: .touchUpInside)
        return button
    }()
    
    private var playSongButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "play.fill", withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playPauseButtonAction), for: .touchUpInside)
        return button
    }()
    
    private var pauseSongButton: UIButton = {
        let button = UIButton()
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .large)
        let largeBoldDoc = UIImage(systemName: "pause.fill", withConfiguration: largeConfig)
        button.setImage(largeBoldDoc, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playPauseButtonAction), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    
    
    // MARK: Initial
    
    init() {
        super.init(frame: .zero)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    // MARK: Public method
    
    func updateView() {
        displayInfoAboutSong()
    }
    
    func setViewDelegate(delegate: MusicViewDelegate) {
        self.delegate = delegate
        displayInfoAboutSong()
    }
    
    /// Изменение иконки play/pause
    func changeStatePlayer(for state: StatePlayer) {
        switch state {
        case .play:
            playSongButton.isHidden = true
            pauseSongButton.isHidden = false
        case .pause:
            playSongButton.isHidden = false
            pauseSongButton.isHidden = true
        }
    }
    
    
    
    // MARK: Private methods
    
    private func displayInfoAboutSong() {
        guard let delegate = delegate else { return }
        let (name, artist, image) = delegate.getInfoAboutSong()
        self.nameSongLabel.text = name
        self.artisSongLabel.text = artist
        self.imageSongLabel.image = image
    }
    
    @objc private func nextButtonAction() {
        delegate?.nextButtonAction()
    }
    
    @objc private func previousButtonAction() {
        delegate?.previousButtonAction()
    }
    
    @objc private func playPauseButtonAction() {
        delegate?.playPauseButtonAction()
    }
    
    
    
    // MARK: Setting up the View
    
    private func setView() {
        addSubviews([imageSongLabel, playSongButton, pauseSongButton, previousSongButton, nextSongButton, nameSongLabel, artisSongLabel])
        installingConstraints()
    }
    
    private func installingConstraints() {
        imageSongLabel.snp.makeConstraints { image in
            image.top.equalTo(safeAreaLayoutGuide).offset(60)
            image.leading.equalTo(self).offset(60)
            image.trailing.equalTo(self).offset(-60)
            image.height.equalTo(UIScreen.main.bounds.width - 120)
        }
        playSongButton.snp.makeConstraints { button in
            button.bottom.equalTo(safeAreaLayoutGuide).offset(-100)
            button.centerX.equalTo(self)
        }
        pauseSongButton.snp.makeConstraints { button in
            button.bottom.equalTo(safeAreaLayoutGuide).offset(-100)
            button.centerX.equalTo(self)
        }
        previousSongButton.snp.makeConstraints { button in
            button.centerY.equalTo(playSongButton.snp.centerY)
            button.trailing.equalTo(playSongButton.snp.leading).offset(-50)
        }
        nextSongButton.snp.makeConstraints { button in
            button.centerY.equalTo(playSongButton.snp.centerY)
            button.leading.equalTo(playSongButton.snp.trailing).offset(50)
        }
        artisSongLabel.snp.makeConstraints { label in
            label.bottom.equalTo(playSongButton.snp.top).offset(-40)
            label.centerX.equalTo(self.snp.centerX)
        }
        nameSongLabel.snp.makeConstraints { label in
            label.bottom.equalTo(artisSongLabel.snp.top).offset(-10)
            label.centerX.equalTo(self.snp.centerX)
        }
    }
}
