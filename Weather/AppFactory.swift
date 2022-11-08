//
//  AppFactory.swift
//  Weather
//
//  Created by Илья Дубровский on 08.11.2022.
//

import UIKit
import Foundation

final class AppFactory {
    
    // MARK: Static property
    static var shared = AppFactory()
    
    
    // MARK: Public methods
    
    func createLocationController() -> UIViewController {
        let locationViewController = AccessToLocationViewController()
        return locationViewController
    }
    
    func createSettingsController() -> UIViewController {
        let settingsViewController = SettingsViewController()
        return settingsViewController
    }
    
    func createWeatherController() -> UINavigationController {
        let weatherViewController = WeatherViewController()
        let navigationController = UINavigationController(rootViewController: weatherViewController)
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .customWhite
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [.foregroundColor: UIColor.customBlack, .font: UIFont(name: "Rubik-Medium", size: 18) ?? UIFont.systemFont(ofSize: 18)]
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        return navigationController
    }
}
