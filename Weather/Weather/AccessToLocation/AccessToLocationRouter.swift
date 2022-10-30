//
//  AccessToLocationRouter.swift
//  Weather
//
//  Created by Илья Дубровский on 30.10.2022.
//

import Foundation

protocol AccessToLocationRoutingLogic {
    func routeToViewWeather()
}

final class AccessToLocationRouter: AccessToLocationRoutingLogic {
    
    private weak var viewController: AccessToLocationViewController?
    
    init(viewController: AccessToLocationViewController) {
        self.viewController = viewController
    }
    
    func routeToViewWeather() {
        let weatherViewController = SettingsViewController()
        weatherViewController.modalTransitionStyle = .partialCurl
        weatherViewController.modalPresentationStyle = .fullScreen
        viewController?.present(weatherViewController, animated: true)
    }
}
