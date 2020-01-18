//
//  ExpenseManager.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 09/07/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import CoreData

class ExpenseManager {
    // MARK: - DECLARATIONS -
    private var fetchRequest:NSFetchRequest<Expense> = Expense.fetchRequest()
    private var sortDescriptor = NSSortDescriptor(key: Constant.persistence.sortDescriptor, ascending: true)
}

// MARK: - DATABASE FUNCTIONS
extension ExpenseManager {

}
