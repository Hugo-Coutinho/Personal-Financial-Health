//
//  ExpenseFormView.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 09/09/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit
import Foundation


class ExpenseFormView: UIView {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var formStackView: UIStackView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var expendedTextField: UITextField!
    @IBOutlet weak var iconImageView: UIImageView!
    
    // MARK: - PROPERTIES -
    private lazy var worker: CoreDataWorkerInput = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorExpense)
    private lazy var blFinancial: BLFinancial = BLFinancial(worker: self.worker)
    
    override func layoutSubviews() {
        self.addConstraint(configureAspectRatio(toItem: self.formStackView, multiplierFirst: 2.0, multiplierSecond: 4.0))
    }
}

// MARK: - EXTERNAL FUNCTIONS -
extension ExpenseFormView {
    func createNewExpense() {
        guard self.inputsIsValid() else { self.invalidInput(); return }
        guard !self.expenseAlreadyExist() else { self.updateExpense(); return }
        self.createExpense()
    }
}

// MARK: - AUX FUNCTIONS -
extension ExpenseFormView {
    private func invalidInput() {
        guard let currentViewController = UIViewController.getVisibileViewController(viewController: ExpenseViewController.self) else { self.ShowAlertSomethingWentWrong(); return }
        Alert.presentOkNativeAlert(title: Constant.view.expenseView.alertExpenseTitleError, message: Constant.view.expenseView.alertInvalidInput, viewController: currentViewController)
    }
    
    private func ShowAlertSomethingWentWrong() {
        guard let currentViewController = UIViewController.getVisibileViewController(viewController: ExpenseViewController.self) else { return }
        Alert.presentOkNativeAlert(title: Constant.view.expenseView.alertExpenseTitleError, message: Constant.view.expenseView.alertSomethingWentWrong, viewController: currentViewController)
    }
    
    private func updateExpense() {
        guard let expense = self.getExpense(),
            let currentViewController = UIViewController.getVisibileViewController(viewController: ExpenseViewController.self) else { self.ShowAlertSomethingWentWrong(); return }
        self.blFinancial.updateExpense(newExpense: expense)
        self.reloadStackView()
        Alert.presentOkNativeAlert(title: Constant.view.expenseView.alertExpenseTitleSuccess, message: Constant.view.expenseView.alertExpenseSaved, viewController: currentViewController)
    }
    
    func createExpense() {
        guard let expense = self.getExpense(),
            let currentViewController = UIViewController.getVisibileViewController(viewController: ExpenseViewController.self) else { self.ShowAlertSomethingWentWrong(); return }
        self.blFinancial.createExpense(newExpense: expense)
        self.reloadStackView()
        Alert.presentOkNativeAlert(title: Constant.view.expenseView.alertExpenseTitleSuccess, message: Constant.view.expenseView.alertExpenseSaved, viewController: currentViewController)
    }
    
    private func reloadStackView() {
        guard let expenseViewController = UIViewController.getVisibileViewController(viewController: ExpenseViewController.self) else { self.ShowAlertSomethingWentWrong(); return }
        expenseViewController.addingListContainerView()
        expenseViewController.mainStackView.reloadStackView()
    }
    
    func expenseAlreadyExist() -> Bool {
        guard let expense = self.getExpense() else { return false }
        return self.blFinancial.currentExpenseExist(newExpense: expense)
    }
    
    func inputsIsValid() -> Bool {
        guard let name = self.nameTextField.text,
            let expended = self.expendedTextField.text,
            !(name.isEmpty || expended.isEmpty) else { return false }
        return true
    }
    
    func getExpense() -> ExpenseItemModel? {
        guard let name = self.nameTextField.text,
            let expendedText = self.expendedTextField.text,
            let expendedValue = Double(expendedText) else { return nil }
        let expenseType = Int16(self.getExpenseType())
        let currentSubItem = ExpenseSubItemModel(date: Date(), expended: expendedValue)
        return ExpenseItemModel(icon: "", name: name, expenseType: expenseType, subItems: [ currentSubItem ])
    }
    
    private func getExpenseType() -> Int {
        guard let expenseViewController = UIViewController.getVisibileViewController(viewController: ExpenseViewController.self),
            let view = expenseViewController.mainStackView.arrangedSubviews.filter({ $0 is ConstantPickerView }).first,
            let pickerView = view as? ConstantPickerView else { return 0 }
        return pickerView.monthsPickerView.selectedRow(inComponent: 0)
        
    }
}

// MARK: - IMPLEMENTS PROTOCOL EXPENSE SUBVIEWS -
extension ExpenseFormView: IExpenseSubView {
    func didSelectRow(mainStack: StackViewController) {
        
    }
    
    func instanceExpenseSubViewFromNib() -> UIView {
        return ExpenseFormView.instanceFromNib(nibName: Constant.view.expenseView.expenseFormView)
    }
}
