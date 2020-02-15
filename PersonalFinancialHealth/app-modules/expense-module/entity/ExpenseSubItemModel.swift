//
//  ExpenseSubItem.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 14/02/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import Foundation
import CoreData

// MARK: - DECLARATIONS & INITIALIZATIONS -
class ExpenseSubItemModel {
    var date: Date
    var expended: Double
    
    init(date: Date, expended: Double) {
        self.date = date
        self.expended = expended
    }
}

// MARK: - MANAGE OBJECT CONVERSION -
extension ExpenseSubItemModel: ManagedObjectConvertible {
    typealias ManagedObject = ExpenseSubItemMO
    
    func toManagedObject(in context: NSManagedObjectContext) -> ExpenseSubItemMO {
        let subItemMO = ExpenseSubItemMO(context: context)
        subItemMO.expended = self.expended
        subItemMO.date = self.date
        return subItemMO
    }
}

// MARK: - MODEL CONVERSION -
extension ExpenseSubItemModel: ManagedObjectProtocol {
    typealias Entity = ExpenseSubItemModel
    
    static func toEntity(MO: ExpenseSubItemMO) -> ExpenseSubItemModel {
        return ExpenseSubItemModel(date: MO.date ?? Date(), expended: MO.expended)
    }
    
}
