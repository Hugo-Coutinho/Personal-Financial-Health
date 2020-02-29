//
//  CoreDataWorker.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 14/02/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataWorkerInput {
    var context: NSManagedObjectContext { get }
    static func make() -> CoreDataWorkerInput
    func createEntities<T: NSManagedObject>(managedObjects: [T]) throws
    func create<T: NSManagedObject>(entity: T) throws
    func read<T: NSManagedObject>(manageObjectType: T.Type, sortDescriptor: [NSSortDescriptor]?) -> [T]?
    func delete<T: NSManagedObject>(entities: [T])
}

class CoreDataWorker: CoreDataWorkerInput {
    
    // MARK: - DECLARATIONS -
    private var maincoreData: CoreDataInput
    var context: NSManagedObjectContext
    
    // MARK: - INITIALIZATIONS -
    init() {
        self.maincoreData = MainCoreData.make()
        self.context = self.maincoreData.context
    }
    
    // MARK: - DI -
    static func make() -> CoreDataWorkerInput {
        return CoreDataWorker.init()
    }
    
    func create<T: NSManagedObject>(entity: T) throws {
        do {
            try self.maincoreData.save()
        } catch  {
            throw ErrorCoreData.notSave
        }
    }
    
    func createEntities<T: NSManagedObject>(managedObjects: [T]) throws {
        do {
            try managedObjects.forEach { (current) in
                try self.create(entity: current)
            }
        } catch  {
            throw ErrorCoreData.notSave
        }
    }
    
    func read<T: NSManagedObject>(manageObjectType: T.Type, sortDescriptor: [NSSortDescriptor]? = nil) -> [T]? {
        guard let sortDescriptor = sortDescriptor else {return nil }
        let fetchRequest:NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T>
        fetchRequest.sortDescriptors = sortDescriptor
        do {
            return try self.maincoreData.context.fetch(fetchRequest)
        } catch {
            return nil
        }
    }
    
    func delete<T: NSManagedObject>(entities: [T]) {
        entities.forEach { (current) in
            self.context.delete(current)
        }
    }
}
