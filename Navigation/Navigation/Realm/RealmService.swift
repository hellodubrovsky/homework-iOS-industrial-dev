//
//  RealmService.swift
//  Navigation
//
//  Created by Илья on 23.08.2022.
//

import Foundation
import RealmSwift


// MARK: - RealmService

final class RealmService {
    private let mainQueue = DispatchQueue.main
    private let backgroundQueue = DispatchQueue(label: "RealmContextQueue", qos: .background)
    
    private func safeWrite(in realm: Realm, _ block: (() -> Void)) throws {
        realm.isInWriteTransaction ? try block() : try realm.write(block)
    }
}



// MARK: RealmService -> DatabaseCoordinatable

extension RealmService: DatabaseCoordinatable {
    
    func create<T>(_ model: T.Type, keyedValue: [String : Any], completion: @escaping (Result<T, DatabaseErrors>) -> Void) where T: Storable {
        do {
            let realm = try Realm()
            try self.safeWrite(in: realm) {
                guard let model = model as? Object.Type else {
                    self.mainQueue.async { completion(.failure(.wrongModel)) }
                    return
                }
                let object = realm.create(model, value: keyedValue, update: .all)
                guard let result = object as? T else {
                    completion(.failure(.wrongModel))
                    return
                }
                completion(.success(result))
            }
        } catch {
            completion(.failure(.customError(description: "Fail to create object in storage.")))
        }
    }
    
    func fetch<T>(_ model: T.Type, predicate: NSPredicate?, completion: @escaping (Result<T, DatabaseErrors>) -> Void) where T : Storable {
        do {
            let realm = try Realm()
            
            if let model = model as? Object.Type {
                var objects = realm.objects(model)
                if let predicate = predicate {
                    objects = objects.filter(predicate)
                }
                
                guard let results = Array(objects) as? [T] else {
                    completion(.failure(.wrongModel))
                    return
                }
                
                // Т.к. UID уникальный, всегда будет возвращаться массив с одним элементом.
                guard results.count == 1 else {
                    completion(.failure(.wrongModel))
                    return
                }
                
                completion(.success(results.first!))
            }
        } catch {
            completion(.failure(.customError(description: "Fail to fetch objects")))
        }
    }
    
    func fetchAll<T>(_ model: T.Type, completion: @escaping (Result<[T], DatabaseErrors>) -> Void) where T : Storable {
        do {
            let realm = try Realm()
            
            if let model = model as? Object.Type {
                var objects = realm.objects(model)
                
                guard let results = Array(objects) as? [T] else {
                    completion(.failure(.wrongModel))
                    return
                }
                completion(.success(results))
            }
        } catch {
            completion(.failure(.customError(description: "Fail to fetch objects")))
        }
    }
}
