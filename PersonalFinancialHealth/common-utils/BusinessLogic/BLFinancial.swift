//
//  BLFinancial.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 09/07/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation

class BLFinancial {
    
    // MARK: - PROPERTIES -
    var worker: CoreDataWorkerInput
    
    // MARK: - INITIALIZER -
    init(worker: CoreDataWorkerInput) {
        self.worker = worker
    }
}

// MARK: - OPEN FUNCTIONS EXPENSE -
extension BLFinancial {
    func createExpense(newExpense: ExpenseItemModel) {
        do {
            try self.worker.create(entity: newExpense.toManagedObject(in: self.worker.context))
        } catch {
            
        }
    }
    
    func updateExpense(newExpense: ExpenseItemModel) {
        guard let expendedValue = newExpense.subItems.first?.expended,
            let managedObject = self.worker.read(manageObjectType: ExpenseItemMO.self)?.filter({ $0.name == newExpense.name && $0.expenseType == newExpense.expenseType }).first else { self.createExpense(newExpense: newExpense); return }
        let newSubItem = ExpenseSubItemModel(date: Date(), expended: expendedValue)
        managedObject.expenseType = newExpense.expenseType
        managedObject.addToSubItems(newSubItem.toManagedObject(in: self.worker.context))
        do {
            try self.worker.context.save()
        } catch  {
            
        }
    }
    
    func getExpenses(successExpenses: @escaping ([ExpenseItemModel]) -> Void, nilExpenses: @escaping (Error?) -> Void) {
        guard let managedObject = self.worker.read(manageObjectType: ExpenseItemMO.self) else { nilExpenses(nil); return }
        successExpenses(managedObject.map({ (current) in return ExpenseItemModel.toEntity(mo: current) }))
    }
    
    func currentExpenseExist(newExpense: ExpenseItemModel) -> Bool {
        guard let _ = self.worker.read(manageObjectType: ExpenseItemMO.self)?.filter({ $0.name == newExpense.name && $0.expenseType == newExpense.expenseType }).first else { return false }
        return true
    }
    
    func resetAppExpenseStorage() {
        self.worker.resetAppStorage(manageObjectType: ExpenseItemMO.self)
        
    }
    
    func resetAppSalaryStorage() {
        self.worker.resetAppStorage(manageObjectType: SalaryMO.self)
    }
    
    func resetAppHistoricalStorage() {
        self.worker.resetAppStorage(manageObjectType: HistoricalMO.self)
    }
}

// MARK: - OPEN FUNCTIONS FUNDS -
extension BLFinancial {
    func getUsefullyFunds(usefullyFund: @escaping (Double) -> Void, invalid: @escaping () -> Void) {
        let managedObject = self.worker.read(manageObjectType: SalaryMO.self)
        guard let wrappedValue = managedObject?.first else { invalid(); return }
        usefullyFund(self.calculateTheUsefullyFunds(net: wrappedValue.usefully, totalExpended: 0.0))
    }
}

// MARK: - AUX FUNCTIONS -
extension BLFinancial {
    func calculateTheUsefullyFunds(net: Double, totalExpended: Double) -> Double {
        return (net - totalExpended)
    }
}
