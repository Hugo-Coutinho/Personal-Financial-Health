//
//  HomePresenterTests.swift
//  PersonalFinancialHealthTests
//
//  Created by BRQ on 04/04/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import XCTest
@testable import PersonalFinancialHealth

class HomePresenterTests: XCTestCase {

    // MARK: - PROPERTIES -
    private var worker: CoreDataWorkerInput?
    private var blFinancial: BLFinancial?
    private lazy var showAlertSubmitSalaryCalled: Bool = false
    private lazy var showAlertAppWasResetedCalled: Bool = false
    
    
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
        self.showAlertSubmitSalaryCalled = false
        self.showAlertAppWasResetedCalled = false
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
    
    func testCheckUserAlreadyInputSalary_shouldCallAlert() {
        // 1. GIVEN
        let presenter = HomePresenter(view: self)

        // 2. WHEN
        presenter.checkUserAlreadyInputSalary()
        
        // 3. THEN
        assert(self.showAlertSubmitSalaryCalled == true)
    }
    
    func testCheckUserAlreadyInputSalary_shouldNotCallAlert() {
        // 1. GIVEN
        let presenter = HomePresenter(view: self)
        let salaryWorker: CoreDataWorkerInput = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorSalary)
        let salaryModel = SalaryModel(net: 2500.0, usefully: 2000.0)
        let salaryMO = salaryModel.toManagedObject(in: self.worker!.context)
        
        // 2. WHEN
        do {
            try salaryWorker.create(entity: salaryMO)
        } catch {
            assertionFailure()
        }
        presenter.checkUserAlreadyInputSalary()
        
        // 3. THEN
        assert(self.showAlertSubmitSalaryCalled == false)
    }
}

// MARK: - IMPLEMENTS HOME PRESENTER -
extension HomePresenterTests: HomePresenterToView {
    func showAlertSubmitSalary() {
        self.showAlertSubmitSalaryCalled = true
    }
    
    public func showAlertAppWasReseted() {
        
    }
}
