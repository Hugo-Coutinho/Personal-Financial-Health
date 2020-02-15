//
//  ExpenseProtocols.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 10/02/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import Foundation


// MARK: - PRESENTER INPUT -
protocol ExpenseViewToPresenter {
    var view: ExpensePresenterToView {get set}
    var interactor: ExpensePresenterToInteractor? {get set}
}

// MARK: - PRESENTER OUTPUT -
protocol ExpensePresenterToView {

}

// MARK: - INTERACTOR INPUT -
protocol ExpensePresenterToInteractor {
    var presenter: ExpenseInteractorToPresenter {get set}
    static func make(presenter: ExpenseInteractorToPresenter) -> ExpensePresenterToInteractor
}

// MARK: - INTERACTOR OUTPUT -
protocol ExpenseInteractorToPresenter {
    
}

