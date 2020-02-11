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
    
    init(presenter: ExpenseInteractorToPresenter) {
        self.presenter = presenter
    }
    
    // MARK: - DI -
    static func make(presenter: ExpenseInteractorToPresenter) -> ExpensePresenterToInteractor {
        return ExpenseInteractor.init(presenter: presenter)
    }
}
