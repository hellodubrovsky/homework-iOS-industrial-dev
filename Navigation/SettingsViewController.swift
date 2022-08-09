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
        let mainView = SettingsView(delegate: self, sortingStatus: checkingForPresenceOfSavedData())
        view = mainView
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.init(named: "colorBaseVK")
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func checkingForPresenceOfSavedData() -> Bool {
        let userDefaults = UserDefaults.standard
        if userDefaults.object(forKey: "sortAlphabetically") == nil {
            userDefaults.setValue(true, forKey: "sortAlphabetically")
            return true
        } else {
            return userDefaults.bool(forKey: "sortAlphabetically")
        }
    }
}





// MARK: - SettingsViewDelegate

extension SettingsViewController: SettingsViewDelegate {
    
    func switchStatusChanged(on: Bool) {
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(on, forKey: "sortAlphabetically")
    }
    
    func pressingButtonToOpenPasswordChangeWindow() {
        let presenter = UpdatePasswordPresenter()
        let vc = UpdatePasswordViewController(presenter: presenter)
        self.present(vc, animated: true)
    }
}
