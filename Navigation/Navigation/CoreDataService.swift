//
//  CoreDataService.swift
//  Navigation
//
//  Created by Илья on 29.08.2022.
//

import Foundation
import CoreData

final class CoreDataService {
    
    private let bundle = Bundle.main
    //private var model: NSManagedObjectModel?
    private var persistentStoreCoordinator: NSPersistentStoreCoordinator?
    
    private lazy var mainContext: NSManagedObjectContext = {
        let mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.persistentStoreCoordinator = self.mainContext.persistentStoreCoordinator
        return mainContext
    }()
    
    
}




extension CoreDataService: DatabaseCoordinatable2 {

    
    func create<T>(_ model: T.Type, keyedValue: [String : Any], completion: @escaping (Result<[T], DatabaseErrors>) -> Void) where T : Storable {
        print("Создать элемент")
    }
    
    func fetch<T>(_ model: T.Type, predicate: NSPredicate?, completion: @escaping (Result<[T], DatabaseErrors>) -> Void) where T : Storable {
        
    }
    
    func fetchAll<T>(_ model: T.Type, completion: @escaping (Result<[T], DatabaseErrors>) -> Void) where T : Storable {
        print("Получить все элементы")
    }
 
}
