//
//  SettingsViewController.swift
//  Navigation
//
//  Created by Илья on 03.08.2022.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    
    // MARK: ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        let mainView = SettingsView(delegate: self, sortingStatus: false)
        view = mainView
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.init(named: "colorBaseVK")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}





// MARK: - SettingsViewDelegate

extension SettingsViewController: SettingsViewDelegate {
    
    func switchStatusChanged(on: Bool) {
        // TODO: Нужно сохранять в UserDefaults
    }
    
    func pressingButtonToOpenPasswordChangeWindow() {
        // TODO: ННужно открыть окно с изменением пароля
    }
}
