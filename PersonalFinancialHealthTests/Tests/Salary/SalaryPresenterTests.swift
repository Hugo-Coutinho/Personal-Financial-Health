//
//  SalaryTests.swift
//  PersonalFinancialHealthTests
//
//  Created by BRQ on 21/02/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import XCTest
@testable import PersonalFinancialHealth

class SalaryPresenterTests: XCTestCase {

    // MARK: - PROPERTIES -
    private var worker: CoreDataWorkerInput?
    private var blFinancial: BLFinancial?
    
    override func setUp() {
        self.worker = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorSalary)
        guard let worker = self.worker else { assertionFailure(); return }
        self.blFinancial = BLFinancial(worker: worker)
    }
    
    override func tearDown() {
        self.blFinancial?.resetAppSalaryStorage()
    }
    
    func testGetNetSalaryInString_ShouldReturnValueInDouble() {
        // 1. GIVEN
        let presenter = SalaryPresenter(view: self)
        // 2. WHEN
        let result = presenter.getNetSalaryFromTextField(netInputValue: "20")
        // 3. THEN
        assert(result == 20.0)
    }
    
    func testGetNetSalaryInString_ShouldReturnZero() {
        // 1. GIVEN
        let presenter = SalaryPresenter(view: self)
        // 2. WHEN
        let result = presenter.getNetSalaryFromTextField(netInputValue: "abc")
        // 3. THEN
        assert(result == 0.0)
    }
    
    func testGetUsefullyMoneyInString_ShouldReturnValueInDouble() {
        // 1. GIVEN
        let presenter = SalaryPresenter(view: self)
        // 2. WHEN
        let result = presenter.getSalaryUsefullyFromTextField(usefullyInputValue: "20")
        // 3. THEN
        assert(result == 20.0)
    }
    
    func testGetUsefullyMoneyInString_ShouldReturnZero() {
        // 1. GIVEN
        let presenter = SalaryPresenter(view: self)
        // 2. WHEN
        let result = presenter.getSalaryUsefullyFromTextField(usefullyInputValue: "abc")
        // 3. THEN
        assert(result == 0.0)
    }
}

extension SalaryPresenterTests: SalaryPresenterToView {
    func updateSalaryLabels() {
        
    }
    
    func didLoadSalary(salary: SalaryModel) {
        
    }
    
    func didNotLoadSalary() {
        
    }
    
    func invalidInput() {
        
    }
    
    func validInput() {
        
    }
    
    func showFailToSaveSalaryAlert() {
        
    }
}
