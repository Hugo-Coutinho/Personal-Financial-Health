//
//  HomeInteractorTests.swift
//  PersonalFinancialHealthTests
//
//  Created by BRQ on 29/03/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import XCTest
@testable import PersonalFinancialHealth

class HomeInteractorTests: XCTestCase {

    // MARK: - PROPERTIES -
    private var worker: CoreDataWorkerInput?
    private var blFinancial: BLFinancial?
    
    // MARK: - UNIT TESTING LIFE CYCLE -
    override func setUp() {
        self.worker = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorExpense)
        guard let worker = self.worker else { assertionFailure(); return }
        self.blFinancial = BLFinancial(worker: worker)
    }
    
    override func tearDown() {
        self.blFinancial?.testResetAppExpenseStorage()
    }
    
    func testResetFinancialInformation_shouldAssertEmptyDatabase() {
        // 1. GIVEN
        let presenter = HomePresenter(view: self)
        let interactor = HomeInteractor.make(presenter: presenter)
        let salaryWorker: CoreDataWorkerInput = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorSalary)
        let salaryModel = SalaryModel(net: 2500.0, usefully: 2000.0)
        let salaryMO = salaryModel.toManagedObject(in: self.worker!.context)
        let expenseModel = ExpenseItemModel(icon: "", name: "", expenseType: 0, subItems: [ExpenseSubItemModel(date: Date(), expended: 900.0)])
        let expenseMO = expenseModel.toManagedObject(in: self.worker!.context)
        
        // 2. WHEN
        do {
            try salaryWorker.create(entity: salaryMO)
            try self.worker?.create(entity: expenseMO)
        } catch {
            assertionFailure()
        }
        interactor.resetFinancialInformation()
        // 3. THEN
        guard let salaryMORead = salaryWorker.read(manageObjectType: SalaryMO.self),
            let expenseItemMOReaded = self.worker?.read(manageObjectType: ExpenseItemMO.self) else { assertionFailure(); return }
        assert(salaryMORead.count == 0)
        assert(expenseItemMOReaded.filter({ $0.expenseType != EnumExpenseItemViewType.Constant.getIndex() }).count == 0)
    }
}

// MARK: - IMPLEMENTS HOME PRESENTER -
extension HomeInteractorTests: HomePresenterToView {
    public func showAlertAppWasReseted() {
        
    }
}
