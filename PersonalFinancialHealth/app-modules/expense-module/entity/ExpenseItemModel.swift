//
//  ExpenseItemModel.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 17/02/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import Foundation
import CoreData

// MARK: - DECLARATIONS & INITIALIZATIONS -
class ExpenseItemModel {
    var icon: String
    var name: String
    var expenseType: Int16
    var subItems: [ExpenseSubItemModel]
    
    init(icon: String, name: String, expenseType: Int16, subItems: [ExpenseSubItemModel]) {
        self.icon = icon
        self.name = name
        self.expenseType = expenseType
        self.subItems = subItems
    }
}

// MARK: - MANAGE OBJECT CONVERSION -
extension ExpenseItemModel: ManagedObjectConvertible {
    typealias ManagedObject = ExpenseItemMO
    
    func toManagedObject(in context: NSManagedObjectContext) -> ExpenseItemMO {
        let worker: CoreDataWorkerInput = CoreDataWorker.make()
        let dbContext = worker.context
        let itemMO = ExpenseItemMO(context: context)
        itemMO.icon = self.icon
        itemMO.name = self.name
        itemMO.expenseType = self.expenseType
        
        self.subItems.forEach { (current) in
            itemMO.addToSubItems(current.toManagedObject(in: dbContext))
        }
        return itemMO
    }
}

// MARK: - MODEL CONVERSION -
extension ExpenseItemModel: ManagedObjectProtocol {
    typealias Entity = ExpenseItemModel
    
    static func toEntity(mo: ExpenseItemMO) -> ExpenseItemModel {
        return ExpenseItemModel(icon: (mo.icon ?? ""), name: (mo.name ?? ""), expenseType: mo.expenseType, subItems: self.getSubItemEntities(mo: mo))
    }
    
    private static func getSubItemEntities(mo: ExpenseItemMO) -> [ExpenseSubItemModel] {
        let subItemsMoAllObjects = mo.subItems?.allObjects.map({ return $0 as! ExpenseSubItemMO })
        guard let subItemsMo = subItemsMoAllObjects,
            !subItemsMo.isEmpty else { return ([] as! [ExpenseSubItemModel]) }
        return subItemsMo.map({ return ExpenseSubItemModel.toEntity(mo: $0) })
    }
}

