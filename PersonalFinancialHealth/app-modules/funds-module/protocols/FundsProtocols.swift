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
    
}

// MARK: - INTERACTOR INPUT -
protocol FundsPresenterToInteractor {
    var presenter: FundsInteractorToPresenter {get set}
    func getFundsFromDataBase() -> Double
    func getDailyValueAvailableFromDataBase() -> Double
}

// MARK: - INTERACTOR OUTPUT -
protocol FundsInteractorToPresenter {

}


