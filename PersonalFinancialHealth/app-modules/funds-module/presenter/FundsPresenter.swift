//
//  FundsPresenter.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 02/03/20.
//  Copyright © 2020 Hugo. All rights reserved.
//

import Foundation

// MARK: - PRESENTER INPUT -
protocol FundsPresenterInput {
    static func make(view: FundsPresenterToView) -> FundsPresenterInput
    func fetchFunds() -> Double
    func fetchDailyValue() -> Double
    func fetchAlreadyUsedValue() -> Double
    func checkUserBudgetState()
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
    
    func fetchFunds() -> Double {
        let funds = self.interactor?.getFundsCalculatedFromDataBase() ?? 0.0
        return funds < 0.0 ? 0.0 : funds
    }

    func fetchDailyValue() -> Double {
        let used = self.interactor?.getDailyValueAvailableFromDataBase() ?? 0.0
        return used < 0.0 ? 0.0 : used
    }
    
    func fetchAlreadyUsedValue() -> Double {
        return self.interactor?.getAlreadyUsedValueFromDataBase() ?? 0.0
    }
    
    func checkUserBudgetState() {
        self.interactor?.playAnimationByCurrentBudgetState(
            happyAnimation: {
            self.view.playHappyAnimation()
        }, sadAnimation: {
            self.view.playSadAnimation()
        })
        
    }
}

// MARK: - IMPLEMENTS INTERACTOR -
extension FundsPresenter: FundsInteractorToPresenter {
    
}

