//
//  MainCoreData.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 09/07/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol ManagedObjectProtocol {
    associatedtype Entity
    func toEntity() -> Entity?
}

protocol ManagedObjectConvertible {
    associatedtype ManagedObject
    func toManagedObject(in context: NSManagedObjectContext) -> ManagedObject?
}


enum ErrorCoreData:Error {
    case notSave
}

class MainCoreData {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    lazy var context:NSManagedObjectContext = {
        return self.appDelegate.persistentContainer.viewContext
    }()
    
    func saveDatabase() throws {
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

