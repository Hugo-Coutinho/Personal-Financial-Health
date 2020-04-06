//
//  ExpenseFormView.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 09/09/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit
import Foundation
import AwesomeStackView

class ExpenseFormView: UIView {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var formStackView: UIStackView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var expendedTextField: UITextField!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var chooseIconView: UIView!
    @IBOutlet weak var shortNameMenuButton: UIImageView!
    @IBOutlet weak var expendedMenuButton: UIImageView!
    
    
    // MARK: - PROPERTIES -
    private lazy var worker: CoreDataWorkerInput = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorExpense)
    private lazy var blFinancial: BLFinancial = BLFinancial(worker: self.worker)
    
    override func layoutSubviews() {
        self.chooseIconView.isHidden = true
        self.shortNameMenuButton.isHidden = true
        self.expendedMenuButton.isHidden = true
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
        Alert.presentOkNativeAlert(title: NSLocalizedString(Constant.view.expenseView.alertExpenseTitleError, comment: ""), message: NSLocalizedString(Constant.view.expenseView.alertInvalidInput, comment: ""), viewController: currentViewController)
    }
    
    private func ShowAlertSomethingWentWrong() {
        guard let currentViewController = UIViewController.getVisibileViewController(viewController: ExpenseViewController.self) else { return }
        Alert.presentOkNativeAlert(title: Constant.view.expenseView.alertExpenseTitleError, message: NSLocalizedString(Constant.view.expenseView.alertSomethingWentWrong, comment: ""), viewController: currentViewController)
    }
    
    private func updateExpense() {
        guard let expense = self.getExpense(),
            let currentViewController = UIViewController.getVisibileViewController(viewController: ExpenseViewController.self) else { self.ShowAlertSomethingWentWrong(); return }
        self.blFinancial.updateExpense(newExpense: expense)
        UIViewController.reloadExpenseStackViewFromParent()
        Alert.presentOkNativeAlert(title: NSLocalizedString(Constant.view.expenseView.alertExpenseTitleSuccess, comment: ""), message: NSLocalizedString(Constant.view.expenseView.alertExpenseSaved, comment: ""), viewController: currentViewController)
    }
    
    func createExpense() {
        guard let expense = self.getExpense(),
            let currentViewController = UIViewController.getVisibileViewController(viewController: ExpenseViewController.self) else { self.ShowAlertSomethingWentWrong(); return }
        self.blFinancial.createExpense(newExpense: expense)
        UIViewController.reloadExpenseStackViewFromParent()
        Alert.presentOkNativeAlert(title: NSLocalizedString(Constant.view.expenseView.alertExpenseTitleSuccess, comment: ""), message: NSLocalizedString(Constant.view.expenseView.alertExpenseSaved, comment: ""), viewController: currentViewController)
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
    func didSelectRow(mainStack: AwesomeStackView) {
        
    }
    
    func instanceExpenseSubViewFromNib() -> UIView {
        return ExpenseFormView.instanceFromNib(nibName: Constant.view.expenseView.expenseFormView)
    }
}
