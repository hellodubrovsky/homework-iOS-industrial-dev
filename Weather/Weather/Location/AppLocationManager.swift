//
//  AppLocationManager.swift
//  Weather
//
//  Created by Илья Дубровский on 17.10.2022.
//

import UIKit
import CoreLocation

final class AppLocationManager: NSObject, CLLocationManagerDelegate {
    
    // MARK: - Static propery
    static var shared = AppLocationManager()
    
    
    
    // MARK: - Private propery
    private var locationManager = CLLocationManager()
    
    
    
    // MARK: - Private init
    
    private override init() {
        super.init()
        self.locationManager.delegate = self
    }
    
    
    
    // MARK: - Public methods
    
    /// Отображение окна, с запросом на разрешение использования локации.
    func showRequestForAccessLocation() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    /// Проверка получения какого-либо ответа на использовании локации. Метод может вернуть: true - пользователь делал выбор, false - выбор не сделан.
    func checkReceiptOfResponse() -> Bool {
        let response = self.locationManager.authorizationStatus
        guard response == .notDetermined else { return true }
        return false
    }
    
    /// Проверка наличия у приложения, доступа к локации. Метод может вернуть: true - доступ к локации есть, false - приложению в доступе отказано.
    func checkingForAccess() -> Bool {
        let response = self.locationManager.authorizationStatus
        switch response {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        case .restricted, .denied, .notDetermined:
            return false
        default:
            preconditionFailure("\nDebug fatal error: AppLocationManager -> Необработанная ошибка.")
        }
    }
    
    /// Получение геокоординат. Метод возращает кортеж из широты и долготы.
    /// Дополнительно, метод проверяет, есть ли у приложения доступ к локации, если нет, вернется nil.
    func gettingCoordinates() -> (latitude: Double, longitude: Double)? {
        guard self.checkingForAccess() else { return nil }
        guard let coordinate = self.locationManager.location?.coordinate else { return nil }
        return (coordinate.latitude, coordinate.longitude)
    }
}
