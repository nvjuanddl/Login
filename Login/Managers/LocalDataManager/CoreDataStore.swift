//
//  CoreDataStore.swift
//  Login
//
//  Created by Juan Delgado Lasso on 23/11/23.
//
//

import UIKit
import CoreData

protocol CoreDataStoreProtocol {
    var managedObjectContext: NSManagedObjectContext { get }
}

class CoreDataStore: CoreDataStoreProtocol {
    
    let resource: String = "Login"
    let documentsDirectory: String = "Login.sqlite"
    
    private var managedObjectModel: NSManagedObjectModel {
        let modelURL = Bundle.main.url(forResource: resource, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }
    
    private var applicationDocumentsDirectory: NSURL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }
    
    private var persistentContainer: NSPersistentStoreCoordinator {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = applicationDocumentsDirectory.appendingPathComponent(documentsDirectory)
        let failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            print("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
        }
        
        return coordinator
    }
    
    var managedObjectContext: NSManagedObjectContext {
        let coordinator = persistentContainer
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }
}
