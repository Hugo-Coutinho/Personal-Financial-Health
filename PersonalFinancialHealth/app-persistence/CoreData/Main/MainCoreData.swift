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
}

