//
//  FundsPresenterTests.swift
//  PersonalFinancialHealthTests
//
//  Created by BRQ on 24/03/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import XCTest
@testable import PersonalFinancialHealth

class FundsPresenterTests: XCTestCase {

    // MARK: - PROPERTIES -
    private var worker: CoreDataWorkerInput?
    private var blFinancial: BLFinancial?
    
    override func setUp() {
        self.worker = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorSalary)
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
    
    func testFetchFunds_shouldAssertTen() {
        // 1. GIVEN
        let presenter: FundsPresenterInput = FundsPresenter.make(view: self)
        let salary = SalaryModel(net: 5.0, usefully: 10.0)
        let salaryMO = salary.toManagedObject(in: self.worker!.context)
        // 2. WHEN
        do {
        try self.worker?.create(entity: salaryMO)
        } catch {
            assertionFailure()
        }
        let result = presenter.fetchFunds()
        // 3. THEN
        assert(result == "R$ 10.0")
    }

    func testFetchDailyValue_shouldAssertHundred() {
        // 1. GIVEN
        let today = Calendar.current.component(.day, from: Date())
        let dateInterval = Calendar.current.dateInterval(of: .month, for: Date())?.end
        let monthLastDate = Calendar.current.date(byAdding: .day, value: -1, to: dateInterval!)
        let endDayOfMonth = Calendar.current.component(.day, from: monthLastDate!)
        let daysLeft = Double(endDayOfMonth - today)
        let presenter: FundsPresenterInput = FundsPresenter.make(view: self)
        let itemModel = ExpenseItemModel(icon: "", name: "", expenseType: 1, subItems: [ExpenseSubItemModel(date: Date(), expended: 300.0)])
        let itemMO = itemModel.toManagedObject(in: self.worker!.context)
        let salary = SalaryModel(net: 5000.0, usefully: 600.0)
        let salaryMO = salary.toManagedObject(in: self.worker!.context)
        // 2. WHEN
        do {
            try self.worker?.create(entity: itemMO)
            try self.worker?.create(entity: salaryMO)
        } catch {
            assertionFailure()
        }
        let result = presenter.fetchDailyValue()
        let assertResult = (600.0 - 300.0) / daysLeft
        // 3. THEN
        assert(result == String(assertResult).formatValueWithR$())
    }
    
    func testFetchAlreadyUsedValue_shouldAssertTen() {
        // 1. GIVEN
        let presenter: FundsPresenterInput = FundsPresenter.make(view: self)
        let itemModel = ExpenseItemModel(icon: "", name: "", expenseType: 1, subItems: [ExpenseSubItemModel(date: Date(), expended: 10.0)])
        let itemMO = itemModel.toManagedObject(in: self.worker!.context)
        // 2. WHEN
        do {
            try self.worker?.create(entity: itemMO)
        } catch {
            assertionFailure()
        }
        let result = presenter.fetchAlreadyUsedValue()
        // 3. THEN
        assert(result == "R$ 10.0")
    }
}

// MARK: - IMPLEMENTS PRESENTER -
extension FundsPresenterTests: FundsPresenterToView {
    
}
