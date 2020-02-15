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
    func create<T: NSManagedObject>(entity: T) throws
    func read<T: NSManagedObject>(entityType: T.Type, sortDescriptor: [NSSortDescriptor]?) -> [T]?
}

class CoreDataWorker: CoreDataWorkerInput {
    
    private var maincoreData: CoreDataInput
    var context: NSManagedObjectContext
    
    init() {
        self.maincoreData = MainCoreData.make()
        self.context = self.maincoreData.context
    }
    
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
    
    func read<T: NSManagedObject>(entityType: T.Type, sortDescriptor: [NSSortDescriptor]? = nil) -> [T]? {
        guard let sortDescriptor = sortDescriptor else {return nil }
        let fetchRequest:NSFetchRequest<T> = T.fetchRequest() as! NSFetchRequest<T>
        fetchRequest.sortDescriptors = sortDescriptor
        do {
            return try self.maincoreData.context.fetch(fetchRequest)
        } catch {
            return nil
        }
    }
    
    func update () {
        
    }
    
    func delete() {
        
    }
}
