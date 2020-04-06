//
//  ExpenseInteractor.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 10/02/20.
//  Copyright © 2020 Hugo. All rights reserved.
//

import Foundation

class ExpenseInteractor: ExpensePresenterToInteractor {
    
    // MARK: - PROPERTIES -
    var presenter: ExpenseInteractorToPresenter
    var worker: CoreDataWorkerInput
    private lazy var blFinancial: BLFinancial = BLFinancial(worker: self.worker)
    
    init(presenter: ExpenseInteractorToPresenter) {
        self.presenter = presenter
        self.worker  = CoreDataWorker.make(sortDescriptionKey: ConstantPersistence.sortDescriptorExpense)
    }
    
    // MARK: - DI -
    static func make(presenter: ExpenseInteractorToPresenter) -> ExpensePresenterToInteractor {
        return ExpenseInteractor.init(presenter: presenter)
    }
    
    func expenseIsEmpty() -> Bool {
        guard let managedObject = self.worker.read(manageObjectType: ExpenseItemMO.self) else { return true }
        return managedObject.isEmpty
    }
    
    func checkFinancialBudget() {
        self.blFinancial.checkFinancialBudget(viewController: ExpenseViewController.self)
    }
}
