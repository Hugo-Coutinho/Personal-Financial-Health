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
    private lazy var blFinancial: BLFinancial = BLFinancial(worker: self.worker)
    
    // MARK: - INITIALIZER -
    init(presenter: FundsInteractorToPresenter) {
        self.presenter = presenter
        self.worker  = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorSalary)
    }
    
    // MARK: - DI -
    static func make(presenter: FundsInteractorToPresenter) -> FundsPresenterToInteractor {
        return FundsInteractor.init(presenter: presenter)
    }
    
    func getFundsFromDataBase() -> Double {
        guard let managedObject = self.worker.read(manageObjectType: SalaryMO.self)?.first else { return 0.0 }
        return managedObject.usefully
    }
    
    func getDailyValueAvailableFromDataBase() -> Double {
        let usefullyValue: Double = self.getFundsFromDataBase()
        let daysLeft: Double = Date().getDaysLeftFromMonth()
        let totalExpense: Double = self.blFinancial.getTotalConstantAndDailyExpense()
        return Double((usefullyValue - totalExpense) / daysLeft).rounded()
    }
    
    func getAlreadyUsedValueFromDataBase() -> Double {
        return self.blFinancial.getTotalConstantAndDailyExpense()
    }
}


