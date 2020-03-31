//
//  FundsProtocols.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 02/03/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import Foundation

// MARK: - PRESENTER INPUT -
protocol FundsViewToPresenter {
    var view: FundsPresenterToView {get set}
    var interactor: FundsPresenterToInteractor? {get set}
}

// MARK: - PRESENTER OUTPUT -
protocol FundsPresenterToView {
    func playHappyAnimation()
    func playSadAnimation()
}

// MARK: - INTERACTOR INPUT -
protocol FundsPresenterToInteractor {
    var presenter: FundsInteractorToPresenter {get set}
    func getFundsCalculatedFromDataBase() -> Double
    func getDailyValueAvailableFromDataBase() -> Double
    func getAlreadyUsedValueFromDataBase() -> Double
    func getUsefullyFunds() -> Double
    func playAnimationByCurrentBudgetState(happyAnimation: @escaping () -> Void, sadAnimation: @escaping () -> Void)
    func isUserAlreadySubmitedAllInformations() -> Bool
}

// MARK: - INTERACTOR OUTPUT -
protocol FundsInteractorToPresenter {

}


