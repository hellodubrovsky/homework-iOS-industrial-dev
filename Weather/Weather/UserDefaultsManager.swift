//
//  UserDefaultsManager.swift
//  Weather
//
//  Created by Илья Дубровский on 27.10.2022.
//

import Foundation

final class UserDefaultsManager {
    
    // MARK: - Static property
    static var shared = UserDefaultsManager()
    
    
    // MARK: - Private property
    private let userDefaults = UserDefaults.standard
    
    
    // MARK: - Methods of the class
    
    /// Проверка существования объекта. Метод может вернуть: true - объект существует, false - объект не найден.
    func checkingExistenceOfAnObject(forKey key: KeysForUserDefaults) -> Bool {
        let searchObjects: Any? = self.userDefaults.object(forKey: key.rawValue)
        guard searchObjects != nil else { return false }
        return true
    }
    
    /// Поиск объекта. Метод может вернуть: найденный объект, или nil - если он не найден.
    func searchForAnObject(byKey key: KeysForUserDefaults) -> Any? {
        return self.userDefaults.object(forKey: key.rawValue)
    }
    
    /// Добавление нового элемента.
    func setValue(_ value: Any?, forKey key: KeysForUserDefaults) {
        self.userDefaults.setValue(value, forKey: key.rawValue)
    }
    
    /// Удаление элемента.
    func removeObject(forKey key: KeysForUserDefaults) {
        self.userDefaults.removeObject(forKey: key.rawValue)
    }
}
