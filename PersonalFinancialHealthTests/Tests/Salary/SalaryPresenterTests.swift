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
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
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
    func showFailToSaveSalaryAlert() {
        
    }
}
