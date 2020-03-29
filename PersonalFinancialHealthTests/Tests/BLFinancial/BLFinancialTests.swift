//
//  BLFinancialTests.swift
//  PersonalFinancialHealthTests
//
//  Created by BRQ on 14/03/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import XCTest
@testable import PersonalFinancialHealth

class BLFinancialTests: XCTestCase {
    
    private var worker: CoreDataWorkerInput?
    private var blFinancial: BLFinancial?

    override func setUp() {
        self.worker = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorExpense)
        guard let worker = self.worker else { assertionFailure(); return }
        self.blFinancial = BLFinancial(worker: worker)
    }

    override func tearDown() {
        self.blFinancial?.resetAppExpenseStorage()
    }

    func testCalculateTheUsefullyFunds() {
        // 1. GIVEN
        // 2. WHEN
        let result = self.blFinancial?.calculateTheUsefullyFunds(usefully: 200.0, totalExpended: 100.0)
        // 3. THEN
        assert(result == 100.0)
    }
    
    func testCurrentExpenseExist_ShouldReturnTrue() {
        // 1. GIVEN
        let newExpense = ExpenseItemModel(icon: "", name: "fla", expenseType: 0, subItems: [ExpenseSubItemModel(date: Date(), expended: 100.0)])
        var result: Bool? = false
        // 2. WHEN
        do {
        try self.worker?.create(entity: newExpense.toManagedObject(in: self.worker!.context))
            result = self.blFinancial?.currentExpenseExist(newExpense: newExpense)
        } catch {
         assertionFailure()
        }
        // 3. THEN
        assert(result == true)
    }
    
    func testCurrentExpenseExist_ShouldReturnFalse() {
        // 1. GIVEN
        let newExpense = ExpenseItemModel(icon: "", name: "fla", expenseType: 0, subItems: [ExpenseSubItemModel(date: Date(), expended: 100.0)])
        var result: Bool? = false
        // 2. WHEN
            result = self.blFinancial?.currentExpenseExist(newExpense: newExpense)
        // 3. THEN
        assert(result == false)
    }
    
    func testResetAppSalaryStorage_shouldAssertEmpty() {
        // 1. GIVEN
        let salaryWorker: CoreDataWorkerInput = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorSalary)
        let business = BLFinancial(worker: salaryWorker)
        let salaryModel = SalaryModel(net: 100.0, usefully: 100.0)
        let salaryMO = salaryModel.toManagedObject(in: self.worker!.context)
        // 2. WHEN
        do {
            try salaryWorker.create(entity: salaryMO)
        } catch {
            assertionFailure()
        }
        business.resetAppSalaryStorage()
        // 3. THEN
        assert(salaryWorker.read(manageObjectType: SalaryMO.self)!.isEmpty == true)
    }
    
    func testResetAppExpenseStorage_shouldAssertEmpty() {
        // 1. GIVEN
        let expenseWorker: CoreDataWorkerInput = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorExpense)
        let business = BLFinancial(worker: expenseWorker)
        let expenseModel = ExpenseItemModel(icon: "", name: "", expenseType: 0, subItems: [ExpenseSubItemModel(date: Date(), expended: 100.0)])
        let expenseMO = expenseModel.toManagedObject(in: self.worker!.context)
        // 2. WHEN
        do {
            try expenseWorker.create(entity: expenseMO)
        } catch {
            assertionFailure()
        }
        business.resetAppExpenseStorage()
        // 3. THEN
        assert(expenseWorker.read(manageObjectType: ExpenseItemMO.self)!.isEmpty == true)
    }
    
    func testFinancialStateUpdateTotalViewColor_shouldAssertGreenColor() {
        // 1. GIVEN
        let expenseWorker: CoreDataWorkerInput = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorExpense)
        let salaryWorker: CoreDataWorkerInput = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorSalary)
        let salaryModel = SalaryModel(net: 2500.0, usefully: 2000.0)
        let salaryMO = salaryModel.toManagedObject(in: self.worker!.context)
        let expenseModel = ExpenseItemModel(icon: "", name: "", expenseType: 0, subItems: [ExpenseSubItemModel(date: Date(), expended: 900.0)])
        let expenseMO = expenseModel.toManagedObject(in: self.worker!.context)

        // 2. WHEN
        do {
            try salaryWorker.create(entity: salaryMO)
            try expenseWorker.create(entity: expenseMO)
        } catch {
            assertionFailure()
        }
        let result = self.blFinancial?.financialStateUpdateTotalViewColor(itemModel: [expenseModel])
        // 3. THEN
        assert(result == UIColor.ExpenseGreen())
    }
    
    func testFinancialStateUpdateTotalViewColor_shouldAssertGreenRed() {
        // 1. GIVEN
        let expenseWorker: CoreDataWorkerInput = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorExpense)
        let salaryWorker: CoreDataWorkerInput = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorSalary)
        let salaryModel = SalaryModel(net: 2500.0, usefully: 2000.0)
        let salaryMO = salaryModel.toManagedObject(in: self.worker!.context)
        let expenseModel = ExpenseItemModel(icon: "", name: "", expenseType: 0, subItems: [ExpenseSubItemModel(date: Date(), expended: 2100.0)])
        let expenseMO = expenseModel.toManagedObject(in: self.worker!.context)
        
        // 2. WHEN
        do {
            try salaryWorker.create(entity: salaryMO)
            try expenseWorker.create(entity: expenseMO)
        } catch {
            assertionFailure()
        }
        let result = self.blFinancial?.financialStateUpdateTotalViewColor(itemModel: [expenseModel])
        // 3. THEN
        assert(result == UIColor.ExpenseRed())
    }
    
    func testGetUsefullyFunds_shouldAssertTen() {
        // 1. GIVEN
        let salaryWorker: CoreDataWorkerInput = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorSalary)
        let salaryModel = SalaryModel(net: 2500.0, usefully: 2000.0)
        let salaryMO = salaryModel.toManagedObject(in: self.worker!.context)
        // 2. WHEN
        do {
            try salaryWorker.create(entity: salaryMO)
        } catch {
            assertionFailure()
        }
        let result = self.blFinancial?.getUsefullyFunds()
        // 3. THEN
        assert(result == 2000.0)
    }
}
