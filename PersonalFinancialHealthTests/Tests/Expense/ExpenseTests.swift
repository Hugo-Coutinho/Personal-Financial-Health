//
//  PersonalFinancialHealthTests.swift
//  PersonalFinancialHealthTests
//
//  Created by BRQ on 11/02/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import XCTest
@testable import PersonalFinancialHealth

class ExpenseTests: XCTestCase {
    
private lazy var worker: CoreDataWorkerInput = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorExpense)
private lazy var blFinancial: BLFinancial = BLFinancial(worker: self.worker)
    
    override func setUp() {
    }
    
    override func tearDown() {
        self.blFinancial.resetAppExpenseStorage()
    }
}

// MARK: - EXPENSE SUBVIEWS -
extension ExpenseTests {
    // MARK: - EXPENSE FORM VIEW -
    func testsInputsIsValid_shouldReturnTrue() {
        // 1. GIVEN
        let formView = ExpenseFormView.instanceFromNib(nibName: Constant.view.expenseView.expenseFormView) as? ExpenseFormView
        // 2. WHEN
        formView?.nameTextField.text = "fla"
        formView?.expendedTextField.text = "10.00"
        let result = formView?.inputsIsValid()
        // 3. THEN
        assert(result == true)
    }
    
    // MARK: - EXPENSE FORM VIEW -
    func testsInputsIsValid_shouldReturnFalse() {
        // 1. GIVEN
        let formView = ExpenseFormView.instanceFromNib(nibName: Constant.view.expenseView.expenseFormView) as? ExpenseFormView
        // 2. WHEN
        formView?.nameTextField.text = "fla"
        formView?.expendedTextField.text = ""
        let result = formView?.inputsIsValid()
        // 3. THEN
        assert(result == false)
    }
    
    // MARK: - EXPENSE FORM VIEW -
    func testGetExpense_shouldReturnExpense() {
        // 1. GIVEN
        let formView = ExpenseFormView.instanceFromNib(nibName: Constant.view.expenseView.expenseFormView) as? ExpenseFormView
        // 2. WHEN
        formView?.nameTextField.text = "fla"
        formView?.expendedTextField.text = "10.00"
        formView?.createNewExpense()
        let result = formView?.getExpense()
        // 3. THEN
        assert(result != nil)
    }
    
    // MARK: - EXPENSE FORM VIEW -
    func testGetExpense_shouldReturnNil() {
        // 1. GIVEN
        let formView = ExpenseFormView.instanceFromNib(nibName: Constant.view.expenseView.expenseFormView) as? ExpenseFormView
        // 2. WHEN
        formView?.nameTextField.text = ""
        formView?.expendedTextField.text = ""
        let result = formView?.getExpense()
        // 3. THEN
        assert(result == nil)
    }
    
    // MARK: - EXPENSE FORM VIEW -
    func testExpenseAlreadyExist_shouldReturnFalse() {
        // 1. GIVEN
        let formView = ExpenseFormView.instanceFromNib(nibName: Constant.view.expenseView.expenseFormView) as? ExpenseFormView
        // 2. WHEN
        formView?.nameTextField.text = "fla maior do mundo"
        formView?.expendedTextField.text = "100.0"
        let result = formView?.expenseAlreadyExist()
        // 3. THEN
        assert(result == false)
    }
    
    // MARK: - EXPENSE FORM VIEW -
    func testExpenseAlreadyExist_shouldReturnTrue() {
        // 1. GIVEN
        let formViewCreateExpense = ExpenseFormView.instanceFromNib(nibName: Constant.view.expenseView.expenseFormView) as? ExpenseFormView
        let formView = ExpenseFormView.instanceFromNib(nibName: Constant.view.expenseView.expenseFormView) as? ExpenseFormView
        // 2. WHEN
        formViewCreateExpense?.nameTextField.text = "fla maior do mundo"
        formViewCreateExpense?.expendedTextField.text = "100.0"
        formViewCreateExpense?.createNewExpense()
        
        formView?.nameTextField.text = "fla maior do mundo"
        formView?.expendedTextField.text = "100.0"
        let result = formView?.expenseAlreadyExist()
        // 3. THEN
        assert(result == true)
    }
}

// MARK: - EXPENSE INSTANCE VIEWs -
extension ExpenseTests {
    
    // MARK: - EXPENSE FORM VIEW -
    func testInstanceExpenseSubViewFromNib_shouldResultLikeExpenseFormView() {
        // 1. GIVEN
        let formView = ExpenseFormView.instanceFromNib(nibName: Constant.view.expenseView.expenseFormView)
        // 2. WHEN
        let result = formView as? ExpenseFormView
        // 3. THEN
        assert(result != nil)
    }
    
    // MARK: - EXPENSE FORM VIEW -
    func testInstanceExpenseSubViewFromNib_shouldResultNil() {
        // 1. GIVEN
        let formView = ExpenseFormView.instanceFromNib(nibName: Constant.view.expenseView.expenseFormView)
        // 2. WHEN
        let result = formView as? ExpenseContainerView
        // 3. THEN
        assert(result == nil)
    }
    
    // MARK: - EXPENSE LIST CONTAINER VIEW -
    func testSetupActiveExpenses_ShouldReturnArrangedSubviewsCountTwo() {
        // 1. GIVEN
        let containerView = ExpenseListContainerView.instanceFromNib(nibName: Constant.view.expenseView.expenseListcontainer) as? ExpenseListContainerView
        // 2. WHEN
        do {
            try self.worker.create(entity: ExpenseItemModel(icon: "", name: "fla", expenseType: 0, subItems: [ExpenseSubItemModel(date: Date(), expended: 2.0)]).toManagedObject(in: self.worker.context))
            try self.worker.create(entity: ExpenseItemModel(icon: "", name: "fla", expenseType: 1, subItems: [ExpenseSubItemModel(date: Date(), expended: 2.0)]).toManagedObject(in: self.worker.context))
            containerView?.setupActiveExpenses()
        } catch {
            assertionFailure()
        }
        // 3. THEN
        assert(containerView?.arrangedSubviews.count == 2)
    }
    
    // MARK: - EXPENSE LIST CONTAINER VIEW -
    func testSetupActiveExpenses_ShouldReturnArrangedSubviewsCountOne() {
        // 1. GIVEN
        let containerView = ExpenseListContainerView.instanceFromNib(nibName: Constant.view.expenseView.expenseListcontainer) as? ExpenseListContainerView
        // 2. WHEN
        do {
            try self.worker.create(entity: ExpenseItemModel(icon: "", name: "fla", expenseType: 1, subItems: [ExpenseSubItemModel(date: Date(), expended: 2.0)]).toManagedObject(in: self.worker.context))
            containerView?.setupActiveExpenses()
        } catch {
            assertionFailure()
        }
        // 3. THEN
        assert(containerView?.arrangedSubviews.count == 1)
    }
}
