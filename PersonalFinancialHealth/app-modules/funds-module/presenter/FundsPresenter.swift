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
}

// MARK: - IMPLEMENTS INTERACTOR -
extension FundsPresenter: FundsInteractorToPresenter {
    
}

