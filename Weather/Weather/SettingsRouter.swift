//
//  SettingsRouter.swift
//  Weather
//
//  Created by Илья Дубровский on 30.10.2022.
//

import Foundation

protocol SettingsRoutingLogic {
    func routeToViewWeather()
}

final class SettingsRouter: SettingsRoutingLogic {
    
    private weak var viewController: SettingsViewController?
    
    init(viewController: SettingsViewController) {
        self.viewController = viewController
    }
    
    func routeToViewWeather() {
        /*let weatherViewController = WEATHER SCREEN
        weatherViewController.modalTransitionStyle = .flipHorizontal
        weatherViewController.modalPresentationStyle = .fullScreen
        viewController?.present(weatherViewController, animated: true)*/
        print("Необходимо в роутере открывать главный экран погоды7")
    }
    
}
