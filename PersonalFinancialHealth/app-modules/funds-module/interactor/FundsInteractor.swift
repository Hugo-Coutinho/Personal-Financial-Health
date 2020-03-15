//
//  FundsInteractor.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 02/03/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import Foundation

// MARK: - INTERACTOR INPUT -
protocol FundsInteractorInput {
    static func make(presenter: FundsInteractorToPresenter) -> FundsPresenterToInteractor
}

class FundsInteractor: FundsInteractorInput, FundsPresenterToInteractor {
    
    // MARK: - PROPERTIES -
    var worker: CoreDataWorkerInput
    var presenter: FundsInteractorToPresenter
    
    // MARK: - INITIALIZER -
    init(presenter: FundsInteractorToPresenter) {
        self.presenter = presenter
        self.worker  = CoreDataWorker.make(sortDescriptionKey: nil)
    }
    
    // MARK: - DI -
    static func make(presenter: FundsInteractorToPresenter) -> FundsPresenterToInteractor {
        return FundsInteractor.init(presenter: presenter)
    }
    
}


