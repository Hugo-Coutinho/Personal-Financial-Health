//
//  MainCoreData.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 09/07/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol ManagedObjectProtocol {
    associatedtype Entity
    associatedtype ManagedObject
    
    static func toEntity(mo: ManagedObject) -> Entity
}

protocol ManagedObjectConvertible {
    associatedtype ManagedObject
    func toManagedObject(in context: NSManagedObjectContext) -> ManagedObject
}

protocol CoreDataInput {
    var context: NSManagedObjectContext { get set }
    static func make() -> CoreDataInput
    func save() throws
    func getEntityFromDatabase<T: NSFetchRequest<NSManagedObject>>(fetchRequest: T) -> [NSManagedObject]
}


enum ErrorCoreData: Error {
    case notSave
    case notDeleted
}

class MainCoreData: CoreDataInput {
    
    // MARK: - DECLARATIONS -
    let appDelegate: AppDelegate
    private var sortDescriptor: NSSortDescriptor
    var context: NSManagedObjectContext
    
    // MARK: - INITIALIZATIONS -
    init() {
        self.appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.sortDescriptor = NSSortDescriptor(key: "", ascending: true)
        self.context = self.appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - DI -
    static func make() -> CoreDataInput {
        return MainCoreData.init()
    }
}

// MARK: - OPEN FUNCTIONS -
extension MainCoreData {
    func save() throws {
        do {
            try self.saveDatabase()
        } catch  {
            throw ErrorCoreData.notSave
        }
    }
    
    func getEntityFromDatabase<T: NSFetchRequest<NSManagedObject>>(fetchRequest: T) -> [NSManagedObject] {
        var result: [NSManagedObject] = []
        do {
            result = try self.context.fetch(fetchRequest)
        } catch {
            assertionFailure()
        }
        return result
    }
    
    private func saveDatabase() throws {
        do {
            try self.context.save()
        } catch  {
            throw ErrorCoreData.notSave
        }
    }
    
    func fetchEntities<T: NSManagedObject>(entity: T.Type, predicate: NSPredicate? = nil, sortDescriptor: [NSSortDescriptor]? = nil) -> [T]? {
        var results: [T]?
        
        if let fetchRequest: NSFetchRequest<T> = T.fetchRequest() as? NSFetchRequest<T> {
            do {
                if let predicate = predicate {
                    fetchRequest.predicate = predicate
                }
                
                if let sortDescriptor = sortDescriptor {
                    fetchRequest.sortDescriptors = sortDescriptor
                }
                results = try context.fetch(fetchRequest)
            } catch  {
                assert(false, error.localizedDescription)
            }
        } else {
            assert(false,"Error: cast to NSFetchRequest<T> failed")
            
        }
        return results
    }
}

