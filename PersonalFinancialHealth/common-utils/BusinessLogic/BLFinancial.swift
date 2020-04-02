//
//  BLFinancial.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 09/07/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import UIKit

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
            assertionFailure()
        }
    }
    
    func getExpenses(successExpenses: @escaping ([ExpenseItemModel]) -> Void, nilExpenses: @escaping (Error?) -> Void) {
        guard let managedObject = self.worker.read(manageObjectType: ExpenseItemMO.self) else { nilExpenses(nil); return }
        successExpenses(managedObject.map({ (current) in return ExpenseItemModel.toEntity(mo: current) }))
    }
    
    func getTotalConstantAndDailyExpense() -> Double {
        var total = 0.0
        self.worker = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorExpense)
        self.getExpenses(successExpenses: { (expenses) in
            total = expenses.map({ $0.subItems.map({ $0.expended }).reduce(0, +) }).reduce(0, +)
        }) { (error) in
            assertionFailure()
        }
        return total
    }
    
    func deleteItem(item: ExpenseItemModel) {
        let expenseWorker = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorExpense)
        let predicate = NSPredicate(format: "name == %@ AND expenseType == %d", item.name, item.expenseType)
        guard let objectToDelete = self.worker.getEntitiesFromDatabase(entityType: ExpenseItemMO.self, predicate: predicate)?.first else { return }
        expenseWorker.delete(entity: objectToDelete)
    }
    
    func currentExpenseExist(newExpense: ExpenseItemModel) -> Bool {
        guard let _ = self.worker.read(manageObjectType: ExpenseItemMO.self)?.filter({ $0.name == newExpense.name && $0.expenseType == newExpense.expenseType }).first else { return false }
        return true
    }
}

// MARK: - CLEAN DATABASE -
extension BLFinancial {
    func testResetAppExpenseStorage() {
        self.worker.resetAppStorage(manageObjectType: ExpenseItemMO.self)
    }
    
    func resetAppExpenseStorage() {
        let constantExpenses = self.getConstantExpenses()
        self.worker.resetAppStorage(manageObjectType: ExpenseItemMO.self)
        constantExpenses.forEach { (currentItem) in
            self.createExpense(newExpense: currentItem)
        }
    }
    
    func resetAppSalaryStorage() {
        self.worker.resetAppStorage(manageObjectType: SalaryMO.self)
    }
}

// MARK: - OPEN FUNCTIONS FUNDS -
extension BLFinancial {
    func getUsefullyFundsRecalculated(usefullyFund: @escaping (Double) -> Void, invalid: @escaping (Error?) -> Void) {
        let salaryWorker = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorSalary)
        let managedObject = salaryWorker.read(manageObjectType: SalaryMO.self)
        guard let wrappedValue = managedObject?.first else { invalid(nil); return }
        usefullyFund(self.calculateTheUsefullyFunds(usefully: wrappedValue.usefully, totalExpended: self.getTotalConstantAndDailyExpense()))
    }
}

// MARK: - AUX FUNCTIONS -
extension BLFinancial {
    func getConstantExpenses() -> [ExpenseItemModel] {
        let predicate = NSPredicate(format: "expenseType == %d", EnumExpenseItemViewType.Constant.getIndex())
        guard let constantItemsMO = self.worker.getEntitiesFromDatabase(entityType: ExpenseItemMO.self, predicate: predicate) else { return [] }
        return constantItemsMO.compactMap({ $0 }).map({ ExpenseItemModel.toEntity(mo: $0) })
    }
    
    func calculateTheUsefullyFunds(usefully: Double, totalExpended: Double) -> Double {
        return (usefully - totalExpended)
    }
}


// MARK: - SECTION & ITEM REUSABLE FUNCTIONs -
extension BLFinancial {
    func financialStateUpdateTotalViewColor(itemModel: [ExpenseItemModel]) -> UIColor {
        let totalUsed = self.getTotalConstantAndDailyExpense()
        let usefully = self.getUsefullyFunds()
        let userSituationIsOk = totalUsed < usefully
        guard userSituationIsOk  else { return UIColor.ExpenseRed() }
        return UIColor.ExpenseGreen()
    }
    
    func getUsefullyFunds() -> Double {
        let salaryWorker = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorSalary)
        guard let managedObject = salaryWorker.read(manageObjectType: SalaryMO.self)?.first else { return 0.0 }
        return managedObject.usefully
    }
}

// MARK: - GLOBAL FINANCIAL STATE  MANAGMENT -
extension BLFinancial {
    func checkFinancialBudget<T: UIViewController>(viewController: T.Type) {
        self.getExpenses(successExpenses: { (expenses) in
            guard expenses.count > 0,
                self.financialStateUpdateTotalViewColor(itemModel: expenses) == UIColor.ExpenseRed() else { return }
            self.showAlertBudgetIsBlack(viewController: T.self)
        }) { (error) in
            assertionFailure()
        }
    }
    
    private func showAlertBudgetIsBlack<T: UIViewController>(viewController: T.Type) {
        let title = NSLocalizedString("financialShowAlertBudgetIsBlackTitle", comment: "")
        let message = NSLocalizedString("financialShowAlertBudgetIsBlackMessage", comment: "")
        guard let currentViewController = UIViewController.getVisibileViewController(viewController: T.self) else { return }
        
        Alert.presentOkNativeAlert(title: title, message: message, viewController: currentViewController)
    }
}
