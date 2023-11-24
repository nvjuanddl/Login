//
//  LocalDataManager.swift
//  Login
//
//  Created by Juan Delgado Lasso on 23/11/23.
//
//

import Foundation
import CoreData

enum PersistenceError: Error {
    case managedObjectContextNotFound
    case objectNotFound
}

enum LocalDataResult<T> {
    case success([T])
    case failure(String)
}

protocol LocalDataManagerProtocol {
    associatedtype T
    func retrieve<T>(_ completion: @escaping (LocalDataResult<T>) -> Void)
}

class LocalDataManager {
    
    let managedObjectContext = CoreDataStore().managedObjectContext
    
    func save<T>(data: Data, type: T.Type) where T: Codable & NSManagedObject {
        do {
            let decoder = JSONDecoder()
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else { return }
            decoder.userInfo[codingUserInfoKeyManagedObjectContext] = managedObjectContext
            _ = try decoder.decode(type.self, from: data)
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
    
    func getObject<T: Codable & NSManagedObject>(key: String, value: String) -> T? {
        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
        request.predicate = NSPredicate(format: "\(key) == %@", value)
        
        do {
            return try managedObjectContext.fetch(request).first
        } catch {
            print(error)
            return nil
        }
    }
}
