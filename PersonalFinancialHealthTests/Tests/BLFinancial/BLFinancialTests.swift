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
        let result = self.blFinancial?.calculateTheUsefullyFunds(net: 200.0, totalExpended: 100.0)
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
}
