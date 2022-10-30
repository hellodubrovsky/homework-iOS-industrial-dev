//
//  AccessToLocationViewController.swift
//  Weather
//
//  Created by Илья Дубровский on 16.10.2022.
//

import UIKit

class AccessToLocationViewController: UINavigationController {
    
    private weak var locationManager = AppLocationManager.shared
    private weak var userDefaultsManager = UserDefaultsManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = AccessToLocationView(delegate: self)
        edit()
    }
    
    private func edit() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(good), name: Notification.Name("G"), object: nil)
    }
    
    @objc func good() {
        print("Пользователь дал какой-то ответ в системной форме - тут нужно закрыть окно.")
    }
}



// MARK: ViewDelegateProtocol

extension AccessToLocationViewController: AccessToLocationViewDelegate {
    
    func permissionButtonIsPressed() {
        self.locationManager?.showRequestForAccessLocation()
    }
    
    func cancelButtonIsPressed() {
        self.userDefaultsManager?.setValue(false, forKey: .accessToLocation)
        self.good()
    }
}
