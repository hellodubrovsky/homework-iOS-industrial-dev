//
//  AccessToLocationViewController.swift
//  Weather
//
//  Created by Илья Дубровский on 16.10.2022.
//

import UIKit

final class AccessToLocationViewController: UINavigationController {
    
    // MARK: Private properties
    
    private var locationManager: AppLocationManager?
    private var userDefaultsManager: UserDefaultsManager?
    private var router: AccessToLocationRoutingLogic?
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.addingAnObserverForLocationAccessResponse()
    }
    
    
    // MARK: Private methods
    
    private func setup() {
        self.view = AccessToLocationView(delegate: self)
        self.locationManager = AppLocationManager.shared
        self.userDefaultsManager = UserDefaultsManager.shared
        self.router = AccessToLocationRouter(viewController: self)
    }
    
    private func addingAnObserverForLocationAccessResponse() {
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(switchingToWeatherScreen), name: .gettingResponseAccessToLocation, object: nil)
    }
    
    @objc
    private func switchingToWeatherScreen() {
        self.router?.routeToViewWeather()
    }
}




// MARK: - ViewDelegateProtocol

extension AccessToLocationViewController: AccessToLocationViewDelegate {
    
    func permissionButtonIsPressed() {
        self.locationManager?.showRequestForAccessLocation()
    }
    
    func cancelButtonIsPressed() {
        self.userDefaultsManager?.setValue(false, forKey: .accessToLocation)
        self.router?.routeToViewWeather()
    }
}
