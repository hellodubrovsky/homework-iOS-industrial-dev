//
//  SettingsViewController.swift
//  Weather
//
//  Created by Илья Дубровский on 30.10.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    // MARK: Private properties
    
    private var presentedView: Setupable!
    private var router: SettingsRoutingLogic!
    private var userDefaultsManager: UserDefaultsManager!
    
    
    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    
    // MARK: Private methods
    
    private func setup() {
        self.userDefaultsManager = UserDefaultsManager.shared
        self.presentedView = SettingsView(delegate: self)
        self.fetchSettingsFromUserDefaults()
        self.router = SettingsRouter(viewController: self)
        guard let view = self.presentedView as? UIView else { return }
        self.view = view
    }
    
    private func fetchSettingsFromUserDefaults() {
        let statusInitialSetup = self.userDefaultsManager.checkingExistenceOfAnObject(forKey: .initialSetup)
        if statusInitialSetup == false {
            let defaultData = SettingsModel(temperatureIndex: 0, windIndex: 0, timeIndex: 1, notificationIndex: 0)
            self.presentedView.setup(with: defaultData)
        } else {
            guard let indexTemperature = self.userDefaultsManager.searchForAnObject(byKey: .unitOfTemperature) as? Int,
                  let indexWind = self.userDefaultsManager.searchForAnObject(byKey: .unitOfdistance) as? Int,
                  let indexTime = self.userDefaultsManager.searchForAnObject(byKey: .timeFormat) as? Int,
                  let indexNotification = self.userDefaultsManager.searchForAnObject(byKey: .accessToNotification) as? Int else { return }
            let data = SettingsModel(temperatureIndex: indexTemperature, windIndex: indexWind, timeIndex: indexTime, notificationIndex: indexNotification)
            self.presentedView.setup(with: data)
        }
    }
    
    private func saveInUserDefaults(settings: SettingsModel) {
        self.userDefaultsManager.setValue(true, forKey: .initialSetup)
        self.userDefaultsManager.setValue(settings.temperatureIndex, forKey: .unitOfTemperature)
        self.userDefaultsManager.setValue(settings.windIndex, forKey: .unitOfdistance)
        self.userDefaultsManager.setValue(settings.timeIndex, forKey: .timeFormat)
        self.userDefaultsManager.setValue(settings.notificationIndex, forKey: .accessToNotification)
    }
}



// MARK: - SettingsViewDelegate

extension SettingsViewController: SettingsViewDelegate {
    func pressedButtonSave(viewModel: SettingsModel) {
        self.saveInUserDefaults(settings: viewModel)
        self.router.routeToViewWeather()
    }
}
