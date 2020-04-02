//
//  CoreDataWorker.swift
//  PersonalFinancialHealthTests
//
//  Created by BRQ on 01/04/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import XCTest
@testable import PersonalFinancialHealth

class CoreDataWorkerTests: XCTestCase {
    
    // MARK: - PROPERTIES -
    private var worker: CoreDataWorkerInput?
    private var blFinancial: BLFinancial?
    
    override func setUp() {
        self.worker = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorExpense)
        guard let worker = self.worker else { assertionFailure(); return }
        self.blFinancial = BLFinancial(worker: worker)
        self.resetExpenseStorage()
        self.resetSalaryStorage()
    }
    
    override func tearDown() {
        self.resetExpenseStorage()
        self.resetSalaryStorage()
    }
    
    // MARK: - AUX METHODS -
    func resetSalaryStorage() {
        let salaryWorker = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorSalary)
        self.blFinancial = BLFinancial(worker: salaryWorker)
        self.blFinancial?.resetAppSalaryStorage()
    }
    
    func resetExpenseStorage() {
        let expenseWorker = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorExpense)
        self.blFinancial = BLFinancial(worker: expenseWorker)
        self.blFinancial?.resetAppExpenseStorage()
    }
    
    func testCreateEntities_shouldAssertNotEmpty() {
        // 1. GIVEN
        let expenseModel = ExpenseItemModel(icon: "", name: "", expenseType: 0, subItems: [ExpenseSubItemModel(date: Date(), expended: 100.0)])
        let expenseModelTwo = ExpenseItemModel(icon: "", name: "", expenseType: 0, subItems: [ExpenseSubItemModel(date: Date(), expended: 120.0)])
        let expenseMO = expenseModel.toManagedObject(in: self.worker!.context)
        let expenseMOTwo = expenseModelTwo.toManagedObject(in: self.worker!.context)
        // 2. WHEN
        do {
            try self.worker?.createEntities(managedObjects: [expenseMO, expenseMOTwo])
        } catch {
            assertionFailure()
        }
        
        // 3. THEN
        assert(self.worker?.read(manageObjectType: ExpenseItemMO.self)!.isEmpty == false)
    }

    func testCreate_shouldAssertNotEmpty() {
        // 1. GIVEN
        let expenseModel = ExpenseItemModel(icon: "", name: "", expenseType: 0, subItems: [ExpenseSubItemModel(date: Date(), expended: 100.0)])
        let expenseMO = expenseModel.toManagedObject(in: self.worker!.context)
        // 2. WHEN
        do {
            try self.worker?.create(entity: expenseMO)
        } catch {
            assertionFailure()
        }
        // 3. THEN
        assert(self.worker?.read(manageObjectType: ExpenseItemMO.self)!.isEmpty == false)
    }
    
    func testgetEntityFromDatabase_shouldAssertNotNil() {
        // 1. GIVEN
        let expenseModel = ExpenseItemModel(icon: "", name: "", expenseType: 0, subItems: [ExpenseSubItemModel(date: Date(), expended: 100.0)])
        let expenseMO = expenseModel.toManagedObject(in: self.worker!.context)
        let predicate = NSPredicate(format: "name == %@ AND expenseType == %d", expenseModel.name, expenseModel.expenseType)
        
        // 2. WHEN
        do {
            try self.worker?.create(entity: expenseMO)
        } catch {
            assertionFailure()
        }
        
        // 3. THEN
        guard let _ = self.worker?.getEntityFromDatabase(entityType: ExpenseItemMO.self, predicate: predicate) else { assertionFailure(); return }
    }

    func testDelete_shouldAssertEmpty() {
        // 1. GIVEN
        let expenseModel = ExpenseItemModel(icon: "", name: "", expenseType: 0, subItems: [ExpenseSubItemModel(date: Date(), expended: 100.0)])
        let expenseMO = expenseModel.toManagedObject(in: self.worker!.context)
        let predicate = NSPredicate(format: "name == %@ AND expenseType == %d", expenseModel.name, expenseModel.expenseType)
        
        // 2. WHEN
        do {
            try self.worker?.create(entity: expenseMO)
        } catch {
            assertionFailure()
        }
        guard let objectToDelete = self.worker?.getEntityFromDatabase(entityType: ExpenseItemMO.self, predicate: predicate) else { assertionFailure(); return }
        self.worker?.delete(entity: objectToDelete)
        
        // 3. THEN
        assert(self.worker?.read(manageObjectType: ExpenseItemMO.self)!.isEmpty == true)
    }
    
    func testResetAppStorage_shouldAssertEmpty() {
        // 1. GIVEN
        let salaryModel = SalaryModel(net: 100.0, usefully: 100.0)
        let salaryMO = salaryModel.toManagedObject(in: self.worker!.context)
        let salaryWorker = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorSalary)
        self.blFinancial = BLFinancial(worker: salaryWorker)
        // 2. WHEN
        do {
            try salaryWorker.create(entity: salaryMO)
        } catch {
            assertionFailure()
        }
        self.blFinancial?.resetAppSalaryStorage()
        // 3. THEN
        assert(salaryWorker.read(manageObjectType: SalaryMO.self)!.isEmpty == true)
    }
}
