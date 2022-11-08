//
//  SettingsRouter.swift
//  Weather
//
//  Created by Илья Дубровский on 30.10.2022.
//

import UIKit
import Foundation

protocol SettingsRoutingLogic {
    func routeToViewWeather()
}

final class SettingsRouter: SettingsRoutingLogic {
    
    private weak var viewController: SettingsViewController?
    private var appFactory = AppFactory.shared
    
    init(viewController: SettingsViewController) {
        self.viewController = viewController
    }
    
    func routeToViewWeather() {
        let weatherNavigationController = appFactory.createWeatherController()
        weatherNavigationController.modalTransitionStyle = .flipHorizontal
        weatherNavigationController.modalPresentationStyle = .fullScreen
        viewController?.present(weatherNavigationController, animated: true)
    }
}
