//
//  ExpensePresenter.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 10/02/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import Foundation

protocol ExpensePresenterInput {
    static func make(view: ExpensePresenterToView) -> ExpensePresenterInput
    func expenseIsEmpty() -> Bool
    func checkFinancialBudget()
}

class ExpensePresenter: ExpensePresenterInput, ExpenseViewToPresenter {

    // MARK: - PROPERTIES -
    var view: ExpensePresenterToView
    var interactor: ExpensePresenterToInteractor?
    
    // MARK: - INITIALIZER -
    init(view: ExpensePresenterToView) {
        self.view = view
        self.interactor = ExpenseInteractor.make(presenter: self)
    }
    
    // MARK: - DI -
    static func make(view: ExpensePresenterToView) -> ExpensePresenterInput {
        return ExpensePresenter.init(view: view)
    }
    
    func expenseIsEmpty() -> Bool {
        guard let interactor = self.interactor else { return true }
        return interactor.expenseIsEmpty()
    }
    
    func checkFinancialBudget() {
        self.interactor?.checkFinancialBudget()
    }
}

// MARK: - IMPLEMENTS INTERACTOR -
extension ExpensePresenter: ExpenseInteractorToPresenter {
    
}
