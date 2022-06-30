//
//  MultimediaViewController.swift
//  Navigation
//
//  Created by Илья on 29.06.2022.
//

import UIKit

final class MultimediaViewController: UIViewController, MultimediaViewDelegate {
    
    // MARK: Private properties
    private let mainView = MultimediaView()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Media"
        mainView.delegate = self
        view = mainView
    }
}



// MARK: - Processing actions on a view

extension MultimediaViewController {
    
    func pushMusicViewController() {
        let controller = MusicViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func pushVideoViewController() {
        let controller = VideoViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func pushAudioRecordViewController() {
        let controller = RecordAudioViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
