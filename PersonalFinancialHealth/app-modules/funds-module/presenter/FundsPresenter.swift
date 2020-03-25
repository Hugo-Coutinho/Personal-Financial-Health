//
//  FundsPresenter.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 02/03/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import Foundation

// MARK: - PRESENTER INPUT -
protocol FundsPresenterInput {
    static func make(view: FundsPresenterToView) -> FundsPresenterInput
    func fetchFunds() -> String
    func fetchDailyValue() -> String
    func fetchAlreadyUsedValue() -> String
}


class FundsPresenter: FundsPresenterInput, FundsViewToPresenter {
    
    // MARK: - DECLARATIONS -
    var view: FundsPresenterToView
    var interactor: FundsPresenterToInteractor?
    
    // MARK: - INITIALIZER -
    init(view: FundsPresenterToView) {
        self.view = view
        self.interactor = FundsInteractor.make(presenter: self)
    }
    
    // MARK: - DI -
    static func make(view: FundsPresenterToView) -> FundsPresenterInput {
        return FundsPresenter.init(view: view)
    }
    
    func fetchFunds() -> String {
        return String(self.interactor?.getFundsFromDataBase() ?? 0.0).formatValueWithR$()
    }

    func fetchDailyValue() -> String {
        return String(self.interactor?.getDailyValueAvailableFromDataBase() ?? 0.0).formatValueWithR$()
    }
    
    func fetchAlreadyUsedValue() -> String {
        return String(self.interactor?.getAlreadyUsedValueFromDataBase() ?? 0.0).formatValueWithR$()
    }
}

// MARK: - IMPLEMENTS INTERACTOR -
extension FundsPresenter: FundsInteractorToPresenter {
    
}

