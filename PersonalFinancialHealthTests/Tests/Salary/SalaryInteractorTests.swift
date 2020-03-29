//
//  SalaryInteractorTests.swift
//  PersonalFinancialHealthTests
//
//  Created by BRQ on 21/03/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import XCTest
@testable import PersonalFinancialHealth

class SalaryInteractorTests: XCTestCase {

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
    
    func testLoadSalary_shouldAssertNetValueEqualToTen() {
        // 1. GIVEN
        let presenter = SalaryPresenter(view: self)
        let interactor = SalaryInteractor.make(presenter: presenter)
        let salary = SalaryModel(net: 10.0, usefully: 100.0)
        let salaryMO = salary.toManagedObject(in: self.worker!.context)
        // 2. WHEN
        do {
         try self.worker!.create(entity: salaryMO)
        } catch {
            assertionFailure()
        }
        let result = interactor.loadSalary()
        // 3. THEN
        assert(result?.usefully == 100.0)
        assert(result?.net == 10.0)
    }
    
    func testLoadNetSalary_shouldAssertNil() {
        // 1. GIVEN
        let presenter = SalaryPresenter(view: self)
        let interactor = SalaryInteractor.make(presenter: presenter)
        // 2. WHEN
        let result = interactor.loadSalary()
        // 3. THEN
        XCTAssertNil(result)
    }
    
    func testUpdateNetSalary_shouldAssertTen() {
        // 1. GIVEN
        let presenter = SalaryPresenter(view: self)
        let interactor = SalaryInteractor(presenter: presenter)
        let salary = SalaryModel(net: 10.0, usefully: 10.0)
        let salaryMO = salary.toManagedObject(in: self.worker!.context)
        // 2. WHEN
            interactor.updateNetSalary(net: salary, wrappedValue: salaryMO)
        // 3. THEN
        assert(self.worker?.read(manageObjectType: SalaryMO.self)?.first?.net == 10.0)
        assert(self.worker?.read(manageObjectType: SalaryMO.self)?.first?.usefully == 10.0)
    }
}

extension SalaryInteractorTests: SalaryPresenterToView {
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
