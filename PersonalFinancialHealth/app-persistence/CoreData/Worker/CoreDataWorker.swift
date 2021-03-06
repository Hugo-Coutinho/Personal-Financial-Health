//
//  CoreDataWorker.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 14/02/20.
//  Copyright © 2020 Hugo. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataWorkerInput {
    var context: NSManagedObjectContext { get }
    var sortDescriptor: [NSSortDescriptor] { get set }
    static func make(sortDescriptionKey: String?) -> CoreDataWorkerInput
    func createEntities<T: NSManagedObject>(managedObjects: [T]) throws
    func create<T: NSManagedObject>(entity: T) throws
    func read<T: NSManagedObject>(manageObjectType: T.Type) -> [T]?
    func delete<T: NSManagedObject>(entity: T)
    func resetAppStorage<T: NSManagedObject>(manageObjectType: T.Type)
    func getEntitiesFromDatabase<T: NSManagedObject>(entityType: T.Type, predicate: NSPredicate) -> [T]?
}

class CoreDataWorker: CoreDataWorkerInput {
    
    // MARK: - DECLARATIONS -
    private var maincoreData: CoreDataInput
    var context: NSManagedObjectContext
    var sortDescriptor: [NSSortDescriptor]
    
    // MARK: - INITIALIZATIONS -
    init(sortDescriptionKey: String?) {
        self.maincoreData = MainCoreData.make()
        self.context = self.maincoreData.context
        self.sortDescriptor = [NSSortDescriptor(key: sortDescriptionKey, ascending: true)]
    }
    
    // MARK: - DI -
    static func make(sortDescriptionKey: String?) -> CoreDataWorkerInput {
        return CoreDataWorker.init(sortDescriptionKey: sortDescriptionKey)
    }
    
    func create<T: NSManagedObject>(entity: T) throws {
        do {
            try self.maincoreData.save()
        } catch {
            throw ErrorCoreData.notSave
        }
    }
    
    func createEntities<T: NSManagedObject>(managedObjects: [T]) throws {
        do {
            try managedObjects.forEach { (current) in
                try self.create(entity: current)
            }
        } catch {
            throw ErrorCoreData.notSave
        }
    }
    
    func read<T: NSManagedObject>(manageObjectType: T.Type) -> [T]? {
        let fetchRequest:NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T>
        fetchRequest.sortDescriptors = self.sortDescriptor
        do {
            return try self.maincoreData.context.fetch(fetchRequest)
        } catch {
            return nil
        }
    }
    
    func delete<T: NSManagedObject>(entity: T) {
        self.context.delete(entity)
        do {
            try self.maincoreData.context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getEntitiesFromDatabase<T: NSManagedObject>(entityType: T.Type, predicate: NSPredicate) -> [T]? {
        let fetchRequest:NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T>
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = self.sortDescriptor
        let fetchResultManaged = fetchRequest as! NSFetchRequest<NSManagedObject>
        let objects = self.maincoreData.getEntityFromDatabase(fetchRequest: fetchResultManaged).map({ $0 as? T })
        guard !objects.isEmpty else { return nil }
        return objects.compactMap({ $0 })
    }
    
    func resetAppStorage<T: NSManagedObject>(manageObjectType: T.Type) {
        let fetchRequest:NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T>
        fetchRequest.sortDescriptors = self.sortDescriptor
        
        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            try self.context.execute(batchDeleteRequest)
        } catch {
            assertionFailure()
        }
    }
}
