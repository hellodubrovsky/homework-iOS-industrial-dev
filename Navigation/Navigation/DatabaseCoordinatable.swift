//
//  DatabaseCoordinatable.swift
//  Navigation
//
//  Created by Илья on 23.08.2022.
//

import Foundation

protocol DatabaseCoordinatable {
    
    /// Создание нового объекта заданного типа.
    func create<T: Storable>(_ model: T.Type, keyedValue: [String: Any], completion: @escaping (Result<T, DatabaseErrors>) -> Void)
   
    /// Получение объектов заданного типа с помощью предиката.
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, completion: @escaping (Result<T, DatabaseErrors>) -> Void)
     
    /// Получение всех объектов заданного типа.
    func fetchAll<T: Storable>(_ model: T.Type, completion: @escaping (Result<[T], DatabaseErrors>) -> Void)
     
    /*
    /// Обновление объекта заданного типа с помощью предиката.
    func update<T: Storable>(_ model: T.Type, predicate: NSPredicate?, keyedValue: [String: Any], completion: @escaping (Result<[T], DatabaseErrors>) -> Void)
    
    /// Удаление объекта заданного типа, с помощью предиката.
    func delete<T: Storable>(_ model: T.Type, predicate: NSPredicate?, completion: @escaping (Result<[T], DatabaseErrors>) -> Void)
    
    /// Удаление всех объектов заданного типа.
    func deleteAll<T: Storable>(_ model: T.Type, completion: @escaping (Result<[T], DatabaseErrors>) -> Void)
     */
}
