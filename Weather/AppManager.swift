//
//  AppManager.swift
//  Weather
//
//  Created by Илья Дубровский on 16.10.2022.
//

import UIKit

final class AppManager {
    
    // MARK: - Static properties
    static var shared = AppManager()
    
    
    
    // MARK: - Public properties
    var presentedViewController: UIViewController
    
    
    
    // MARK: - Private properties
    
    private var locationManager = AppLocationManager.shared
    private var userDefaultsManager = UserDefaultsManager.shared
    
    
    
    // MARK: - Private init
    
    private init() {
        
        /*
         locationManagerResponse - проверят был ли какой-то ответ пользователя, в нативной форме Apple на доступ к локации.
         userDefaultsManagerResponse - проверяет был ли от пользователя ответ, на ограничение доступа к локации (отдельная кнопка).
         responseLocationAccess - объединяет ответы от locationManagerResponse и userDefaultsManagerResponse.
         */
        
        let locationManagerResponse: Bool = self.locationManager.checkReceiptOfResponse()
        let userDefaultsManagerResponse: Bool = self.userDefaultsManager.checkingExistenceOfAnObject(forKey: .accessToLocation)
        let responseLocationAccess: Bool = locationManagerResponse || userDefaultsManagerResponse
        self.presentedViewController = responseLocationAccess ? VVVViewController() : AccessToLocationViewController()
    }
}
