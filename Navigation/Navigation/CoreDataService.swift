//
//  CoreDataService.swift
//  Navigation
//
//  Created by Илья Дубровский on 13.09.2022.
//

import Foundation
import CoreData

final class CoreDataService {
    
    private let modelName: String
    private let model: NSManagedObjectModel
    private let persistentStoreCoordinator: NSPersistentStoreCoordinator
    
    private lazy var mainContext: NSManagedObjectContext = {
        let mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return mainContext
    }()
    
    private lazy var backgroundContext: NSManagedObjectContext = {
        let backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.mergePolicy = NSOverwriteMergePolicy
        backgroundContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        return backgroundContext
    }()
    
    /// Инициализация CoreDataService, где в свойство url передается путь до файла .xcdatamodeld.
    init(url: URL) {
        guard let model = NSManagedObjectModel(contentsOf: url) else { fatalError("[class: CoreDataService] --> Error: I can't create a model database.") }
        self.modelName = "CoreDataModel."    // TODO: В дальнейшем нужен универсальный вариант для нейминга модели, в случае когда используются разные файлы .xcdatamodeld.
        self.model = model
        self.persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        self.configuringDatabase()
    }
    
    private func configuringDatabase() {
        let storeCoordinator = self.persistentStoreCoordinator
        let fileManager = FileManager.default
        let documentDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let persistentStoreURL = documentDirectoryURL?.appendingPathExtension(self.modelName + "sqlite")
        do {
            let option: [String: Any] = [NSInferMappingModelAutomaticallyOption: true]
            try storeCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: persistentStoreURL, options: option)
        } catch {
            print("[class: CoreDataService] --> Error: Error when adding persistent store.")
        }
    }
}



// MARK: - DatabaseCoordinatable

extension CoreDataService: DatabaseCoordinatable {
    
     /* MARK: Краткая справка, для метода создания нового объекта.
     Логика реализации следующая:
     1. Создается описание сущности (entityDescription) с именем модели.
     2. Создает экземпляр класса, который реализует поведение для объекта базовой модели данных. В него помещается описание сущности.
     3. В объект добавляются необходимы атрибуты, в данном случае передаются все ключи и значения, которые соответсвуют модели coreData.
     4. Проверка, что созданный объект с атрибутами, соответсвует типу модели (T). Чтобы не было расхождений в моделях.
     5. Проверка, что в контексте нет незафиксированных изменений.
     6. Сохранение контекста. */

    func create<T>(_ model: T.Type, keyedValue: [String: Any], completion: @escaping (Result<T, DatabaseErrors>) -> Void) where T : Storable {
        self.backgroundContext.perform { [weak self] in
            guard let self = self else {
                completion(.failure(.unknown))
                return
            }
            guard let entityDescription = NSEntityDescription.entity(forEntityName: String(describing: model.self), in: self.backgroundContext) else {
                completion(.failure(.customError(description: "EntityDescription was not possible to create it.")))
                return
            }
            let managedObject = NSManagedObject(entity: entityDescription, insertInto: self.backgroundContext)
            managedObject.setValuesForKeys(keyedValue)
            guard let object = managedObject as? T else {
                completion(.failure(.customError(description: "The object does not match the type T.")))
                return
            }
            guard self.backgroundContext.hasChanges else {
                completion(.failure(.customError(description: "There are unfixed changes in the context.")))
                return
            }
            do {
                try self.backgroundContext.save()
                self.mainContext.perform {
                    completion(.success(object))
                }
            } catch let error {
                completion(.failure(.customError(description: "Unable to save changes of main context.\nError - \(error.localizedDescription)")))
            }
        }
    }
    
    
    
    /* MARK: Краткая справка, для метода получения объектов заданного типа.
    Логика реализации следующая:
    1. Проходит проверка, что модель соотвествует классу NSManagedObject. Чтобы была возможность выполнять запросы в БД.
    2. Внутри контекста, создается запрос.
    3. К запросу добавляется предикат (условие для заданного типа).
    4. Создается свойство, по которому будет получен результат в виде массива с типом NSFetchRequestResult.
    5. Cоздается свойство, по которому будет получен список всех найденных объектов, которые соответсвуют типу переданной модели (T). */
    
    func fetch<T>(_ model: T.Type, predicate: NSPredicate?, completion: @escaping (Result<[T], DatabaseErrors>) -> Void) where T : Storable {
        guard let model = model as? NSManagedObject.Type else {
            completion(.failure(.wrongModel))
            return
        }
        self.backgroundContext.perform { [weak self] in
            guard let self = self else { completion(.failure(.unknown)); return }
            let request = model.fetchRequest()
            request.predicate = predicate
            guard
                let fetchRequestResult = try? self.backgroundContext.fetch(request),
                let fetchObjects = fetchRequestResult as? [T]
            else {
                self.mainContext.perform {
                    completion(.failure(.wrongModel))
                }
                return
            }
            self.mainContext.perform {
                completion(.success(fetchObjects))
            }
        }
    }
    
    
    
    func fetchAll<T>(_ model: T.Type, completion: @escaping (Result<[T], DatabaseErrors>) -> Void) where T : Storable {
        self.fetch(model, predicate: nil, completion: completion)
    }
    
    
    
    func delete<T>(_ model: T.Type, predicate: NSPredicate?, completion: @escaping (Result<[T], DatabaseErrors>) -> Void) where T : Storable {
        self.fetch(model, predicate: predicate) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let fetchedObjects):
                guard let fetchedObjects = fetchedObjects as? [NSManagedObject] else {
                    completion(.failure(.wrongModel))
                    return
                }
                fetchedObjects.forEach { self.backgroundContext.delete($0) }
                let deleteObjects = fetchedObjects as? [T] ?? []
                guard self.backgroundContext.hasChanges else {
                    completion(.failure(.customError(description: "There are unfixed changes in the context.")))
                    return
                }
                do {
                    try self.backgroundContext.save()
                    self.mainContext.perform {
                        completion(.success(deleteObjects))
                    }
                } catch let error {
                    completion(.failure(.customError(description: "Unable to save changes of main context.\nError - \(error.localizedDescription)")))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    
    
    func deleteAll<T>(_ model: T.Type, completion: @escaping (Result<[T], DatabaseErrors>) -> Void) where T : Storable {
        self.delete(model, predicate: nil, completion: completion)
    }
}
