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
    
    private var worker: CoreDataWorkerInput?
    private var blFinancial: BLFinancial?
    
    override func setUp() {
        self.setExpenseAsRootViewController(controller: self.instantiateExpense())
        self.worker = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorExpense)
        guard let worker = self.worker else { assertionFailure(); return }
        self.blFinancial = BLFinancial(worker: worker)
    }
    
    override func tearDown() {
        self.blFinancial?.resetAppExpenseStorage()
    }
}

// MARK: - HELPER FUNCTIONS -
extension ExpenseTests {
    private func setExpenseAsRootViewController(controller: ExpenseViewController) {
        let nav = UINavigationController(rootViewController: controller)
        UIApplication.shared.keyWindow?.rootViewController = nav
    }
    
    private func instantiateExpense() -> ExpenseViewController {
        let storyboard = UIStoryboard(name: "Expense", bundle: nil)
        let expenseView = storyboard.instantiateViewController(withIdentifier: "ExpenseViewController") as! ExpenseViewController
        expenseView.mainStackView = StackViewController()
        return expenseView
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
        let name = "fla maior do mundo"
        let expended = "100.0"
        // 2. WHEN
        formViewCreateExpense?.nameTextField.text = name
        formViewCreateExpense?.expendedTextField.text = expended
        formViewCreateExpense?.createNewExpense()

        formView?.nameTextField.text = name
        formView?.expendedTextField.text = expended
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
    func testSetupActiveExpenses_ShouldReturnArrangedSubviewsCountZero() {
        // 1. GIVEN
        let containerView = ExpenseListContainerView.instanceFromNib(nibName: Constant.view.expenseView.expenseListcontainer) as? ExpenseListContainerView
        // 2. WHEN
        containerView?.setupActiveExpenses()
        // 3. THEN
        assert(containerView?.arrangedSubviews.count == 0)
    }
    
    // MARK: - EXPENSE LIST CONTAINER VIEW -
    func testSetupActiveExpenses_ShouldReturnArrangedSubviewsCountTwo() {
        // 1. GIVEN
        let containerView = ExpenseListContainerView.instanceFromNib(nibName: Constant.view.expenseView.expenseListcontainer) as? ExpenseListContainerView
        let item = ExpenseItemModel(icon: "", name: "fla", expenseType: 1, subItems: [ExpenseSubItemModel(date: Date(), expended: 2.0)]).toManagedObject(in: self.worker!.context)
        // 2. WHEN
        do {
            try self.worker?.create(entity: item)
            containerView?.setupActiveExpenses()
        } catch {
            assertionFailure()
        }
        // 3. THEN
        assert(containerView?.arrangedSubviews.count == 2)
    }
    
//    // MARK: - EXPENSE LIST CONTAINER VIEW -
//    func testSetupActiveExpenses_ShouldReturnArrangedSubviewsCountTwo() {
//        // 1. GIVEN
//        let containerView = ExpenseListContainerView.instanceFromNib(nibName: Constant.view.expenseView.expenseListcontainer) as? ExpenseListContainerView
//        // 2. WHEN
//        do {
//            try self.worker?.create(entity: ExpenseItemModel(icon: "", name: "fla", expenseType: 0, subItems: [ExpenseSubItemModel(date: Date(), expended: 2.0)]).toManagedObject(in: self.worker!.context))
//            try self.worker?.create(entity: ExpenseItemModel(icon: "", name: "fla", expenseType: 1, subItems: [ExpenseSubItemModel(date: Date(), expended: 2.0)]).toManagedObject(in: self.worker!.context))
//            containerView?.setupActiveExpenses()
//        } catch {
//            assertionFailure()
//        }
//        // 3. THEN
//        assert(containerView?.arrangedSubviews.count == 2)
//    }
//
//    // MARK: - EXPENSE LIST CONTAINER VIEW -
//    func testSetupActiveExpenses_ShouldReturnArrangedSubviewsCountOne() {
//        // 1. GIVEN
//        let containerView = ExpenseListContainerView.instanceFromNib(nibName: Constant.view.expenseView.expenseListcontainer) as? ExpenseListContainerView
//        // 2. WHEN
//        do {
//            try self.worker?.create(entity: ExpenseItemModel(icon: "", name: "fla", expenseType: 1, subItems: [ExpenseSubItemModel(date: Date(), expended: 2.0)]).toManagedObject(in: self.worker!.context))
//            containerView?.setupActiveExpenses()
//        } catch {
//            assertionFailure()
//        }
//        // 3. THEN
//        assert(containerView?.arrangedSubviews.count == 1)
//    }
    
    // MARK: - EXPENSE SECTION VIEW -
    func testGetExpenseType_shouldReturnZero() {
        // 1. GIVEN
        let sectionView = ExpenseListSectionView.instanceFromNib(nibName: Constant.view.expenseView.expenseSection) as? ExpenseListSectionView
        let itemModel = [ExpenseItemModel(icon: "", name: "", expenseType: 0, subItems: [ExpenseSubItemModel(date: Date(), expended: 0.0)])]
        // 2. WHEN
        let result = sectionView?.getExpenseType(itemModel: itemModel, index: 0)
        // 3. THEN
        assert(result == 0)
    }
    
    // MARK: - EXPENSE SECTION VIEW -
    func testGetExpenseType_shouldReturnOne() {
        // 1. GIVEN
        let sectionView = ExpenseListSectionView.instanceFromNib(nibName: Constant.view.expenseView.expenseSection) as? ExpenseListSectionView
        let itemModel = [ExpenseItemModel(icon: "", name: "", expenseType: 1, subItems: [ExpenseSubItemModel(date: Date(), expended: 0.0)])]
        // 2. WHEN
        let result = sectionView?.getExpenseType(itemModel: itemModel, index: 1)
        // 3. THEN
        assert(result == 1)
    }
    
    // MARK: - EXPENSE SECTION VIEW -
    func testGetTotalDailyExpended_shouldReturnStringThree() {
        // 1. GIVEN
        let sectionView = ExpenseListSectionView.instanceFromNib(nibName: Constant.view.expenseView.expenseSection) as? ExpenseListSectionView
        let itemModel = [ExpenseItemModel(icon: "", name: "", expenseType: 1, subItems: [ExpenseSubItemModel(date: Date(), expended: 3.0)])]
        // 2. WHEN
        let result = sectionView?.getTotalDailyExpended(itemModel: itemModel)
        // 3. THEN
        guard let finalResult = result else { assertionFailure(); return }
        assert(finalResult == "3.0")
    }
    
    // MARK: - EXPENSE SECTION VIEW -
    func testGetTotalConstantExpended_shouldReturnStringFour() {
        // 1. GIVEN
        let sectionView = ExpenseListSectionView.instanceFromNib(nibName: Constant.view.expenseView.expenseSection) as? ExpenseListSectionView
        let itemModel = [ExpenseItemModel(icon: "", name: "", expenseType: 0, subItems: [ExpenseSubItemModel(date: Date(), expended: 4.0)])]
        // 2. WHEN
        let result = sectionView?.getTotalConstantExpended(itemModel: itemModel)
        // 3. THEN
        guard let finalResult = result else { assertionFailure(); return }
        assert(finalResult == "4.0")
    }
    
    // MARK: - EXPENSE SECTION VIEW -
    func testGetTotalExpendedToConstantExpense_shouldReturnStringTen() {
        // 1. GIVEN
        let sectionView = ExpenseListSectionView.instanceFromNib(nibName: Constant.view.expenseView.expenseSection) as? ExpenseListSectionView
        let itemModel = [ExpenseItemModel(icon: "", name: "", expenseType: 0, subItems: [ExpenseSubItemModel(date: Date(), expended: 10.0)])]
        // 2. WHEN
        let result = sectionView?.getTotalExpended(itemModel: itemModel, index: 0)
        // 3. THEN
        guard let finalResult = result else { assertionFailure(); return }
        assert(finalResult == "10.0")
    }
    
    // MARK: - EXPENSE SECTION VIEW -
    func testGetTotalExpendedToDailyExpense_shouldReturnStringTen() {
        // 1. GIVEN
        let sectionView = ExpenseListSectionView.instanceFromNib(nibName: Constant.view.expenseView.expenseSection) as? ExpenseListSectionView
        let itemModel = [ExpenseItemModel(icon: "", name: "", expenseType: 1, subItems: [ExpenseSubItemModel(date: Date(), expended: 10.0)])]
        // 2. WHEN
        let result = sectionView?.getTotalExpended(itemModel: itemModel, index: 1)
        // 3. THEN
        guard let finalResult = result else { assertionFailure(); return }
        assert(finalResult == "10.0")
    }

    // MARK: - EXPENSE SECTION VIEW -
    func testGetExpenseTypeValue_shouldAssertConstantString() {
        // 1. GIVEN
        let sectionIndex = 0
        let sectionView = ExpenseListSectionView.instanceFromNib(nibName: Constant.view.expenseView.expenseSection) as? ExpenseListSectionView
        // 2. WHEN
        let result = sectionView?.getExpenseTypeValue(sectionIndex: sectionIndex)
        // 3. THEN
        guard let finalResult = result else { assertionFailure(); return }
        assert(finalResult == "Constant Expense")
    }
    
    // MARK: - EXPENSE SECTION VIEW -
    func testGetExpenseTypeValue_shouldAssertDailyString() {
        // 1. GIVEN
        let sectionIndex = 1
        let sectionView = ExpenseListSectionView.instanceFromNib(nibName: Constant.view.expenseView.expenseSection) as? ExpenseListSectionView
        // 2. WHEN
        let result = sectionView?.getExpenseTypeValue(sectionIndex: sectionIndex)
        // 3. THEN
        guard let finalResult = result else { assertionFailure(); return }
        assert(finalResult == "Daily Expense")
    }
    
    // MARK: - EXPENSE SECTION VIEW -
    func testConfigureUserInteraction_shouldAssertEnable() {
        // 1. GIVEN
        let totalExpended = "2.0"
        let sectionView = ExpenseListSectionView.instanceFromNib(nibName: Constant.view.expenseView.expenseSection) as? ExpenseListSectionView
        // 2. WHEN
        sectionView?.configureUserInteraction(totalExpended: totalExpended)
        // 3. THEN
        assert(sectionView?.isUserInteractionEnabled == true)
    }

    // MARK: - EXPENSE SECTION VIEW -
    func testConfigureUserInteraction_shouldAssertDisable() {
        // 1. GIVEN
        let totalExpended = "0"
        let sectionView = ExpenseListSectionView.instanceFromNib(nibName: Constant.view.expenseView.expenseSection) as? ExpenseListSectionView
        // 2. WHEN
        sectionView?.configureUserInteraction(totalExpended: totalExpended)
        // 3. THEN
        assert(sectionView?.isUserInteractionEnabled == false)
    }

    // MARK: - EXPENSE ITEM VIEW -
    func testGetItemExpense_shouldAssertTen() {
        // 1. GIVEN
        let itemView = ExpenseListItemView.instanceFromNib(nibName: Constant.view.expenseView.expenseListItem) as? ExpenseListItemView
        let item = ExpenseItemModel(icon: "", name: "", expenseType: 0, subItems: [ExpenseSubItemModel(date: Date(), expended: 10.0)])
        // 2. WHEN
        let result = itemView?.getItemExpense(itemModel: item)
        // 3. THEN
        assert(result == "R$ 10.0")
    }
    
    // MARK: - EXPENSE SUBITEM VIEW -
    func testGetDate_shouldAssertDateFormatted() {
        // 1. GIVEN
        let subItemView = ExpenseListSubItemView.instanceFromNib(nibName: Constant.view.expenseView.expenseListSubitem) as? ExpenseListSubItemView
        // 2. WHEN
        let result = subItemView?.getDate(date: Date())
        // 3. THEN
        assert(result == Date().getFormattedDate())
    }

    // MARK: - EXPENSE SUBITEM VIEW -
    func testGetExpense_shouldAssertExpenseFormatted() {
        // 1. GIVEN
        let subItemView = ExpenseListSubItemView.instanceFromNib(nibName: Constant.view.expenseView.expenseListSubitem) as? ExpenseListSubItemView
        // 2. WHEN
        let result = subItemView?.getExpense(expense: 1251.25)
        let resultExpected = "R$ 1251.25"
        // 3. THEN
        assert(result == resultExpected)
    }
}

