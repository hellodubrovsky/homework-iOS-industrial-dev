//
//  AccessToLocationRouter.swift
//  Weather
//
//  Created by Илья Дубровский on 30.10.2022.
//

import Foundation

protocol AccessToLocationRoutingLogic {
    func routeToViewSettings()
}

final class AccessToLocationRouter: AccessToLocationRoutingLogic {
    
    private weak var viewController: AccessToLocationViewController?
    private var appFactory = AppFactory.shared
    
    init(viewController: AccessToLocationViewController) {
        self.viewController = viewController
    }
    
    func routeToViewSettings() {
        let settingsViewController = appFactory.createSettingsController()
        settingsViewController.modalTransitionStyle = .flipHorizontal
        settingsViewController.modalPresentationStyle = .fullScreen
        viewController?.present(settingsViewController, animated: true)
    }
}
