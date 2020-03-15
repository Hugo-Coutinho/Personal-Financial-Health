//
//  ExpenseInteractor.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 10/02/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import Foundation

class ExpenseInteractor: ExpensePresenterToInteractor {
    
    // MARK: - PROPERTIES -
    var presenter: ExpenseInteractorToPresenter
    var worker: CoreDataWorkerInput
    
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
}
