//
//  MultimediaView.swift
//  Navigation
//
//  Created by Илья on 29.06.2022.
//

import UIKit
import SnapKit

protocol MultimediaViewDelegate: AnyObject {
    func pushMusicViewController()
    func pushVideoViewController()
    func pushAudioRecordViewController()
}



final class MultimediaView: UIView {
    
    // MARK: Public properties
    weak var delegate: MultimediaViewDelegate?
    
    
    
    // MARK: Private properties / Create UI-elements
    
    private lazy var musicButton: UIButton = {
        let button = CustomButton(title: "Music", titleColor: .white, backgoundColor: UIColor.init(named: "colorBaseVK")!, cornerRadius: 10) { self.delegate?.pushMusicViewController() }
        return button
    }()
    
    private lazy var videoButton: UIButton = {
        let button = CustomButton(title: "Video", titleColor: .white, backgoundColor: UIColor.init(named: "colorBaseVK")!, cornerRadius: 10) { self.delegate?.pushVideoViewController() }
        return button
    }()
    
    private lazy var audioRecordButton: UIButton = {
        let button = CustomButton(title: "Record audio", titleColor: .white, backgoundColor: UIColor.init(named: "colorBaseVK")!, cornerRadius: 10) { self.delegate?.pushAudioRecordViewController() }
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
    
    
    
    // MARK: Private methods / Set view.
    
    private func setView() {
        backgroundColor = .white
        self.addSubviews([musicButton, videoButton, audioRecordButton])
        installingConstraints()
    }
    
    private func installingConstraints() {
        self.musicButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide).inset(100)
            make.width.equalTo(180)
            make.height.equalTo(80)
        }
        self.videoButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(musicButton.snp.bottom).offset(50)
            make.width.equalTo(180)
            make.height.equalTo(80)
        }
        self.audioRecordButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(videoButton.snp.bottom).offset(50)
            make.width.equalTo(180)
            make.height.equalTo(80)
        }
    }
}
