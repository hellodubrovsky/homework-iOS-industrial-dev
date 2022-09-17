//
//  DatabaseCoordinatable.swift
//  Navigation
//
//  Created by Илья on 23.08.2022.
//

import Foundation

enum DatabaseError: Error {
    /// Невозможно добавить хранилище.
    case store(model: String)
    /// Не найден momd файл.
    case find(model: String, bundle: Bundle?)
    /// Не найдена модель объекта.
    case wrongModel
    /// Кастомная ошибка.
    case error(desription: String)
    /// Неизвестная ошибка.
    case unknown(error: Error)
}

protocol DatabaseCoordinatable {
    
    /// Создание нового объекта заданного типа.
    func create<T: Storable>(_ model: T.Type, keyedValue: [String: Any], completion: @escaping (Result<T, DatabaseErrors>) -> Void)
   
    /// Получение объектов заданного типа с помощью предиката.
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, completion: @escaping (Result<[T], DatabaseErrors>) -> Void)
     
    /// Получение всех объектов заданного типа.
    func fetchAll<T: Storable>(_ model: T.Type, completion: @escaping (Result<[T], DatabaseErrors>) -> Void)
    
    /// Удаление объекта заданного типа, с помощью предиката.
    func delete<T: Storable>(_ model: T.Type, predicate: NSPredicate?, completion: @escaping (Result<[T], DatabaseErrors>) -> Void)
    
    /// Удаление всех объектов заданного типа.
    func deleteAll<T: Storable>(_ model: T.Type, completion: @escaping (Result<[T], DatabaseErrors>) -> Void)
}
