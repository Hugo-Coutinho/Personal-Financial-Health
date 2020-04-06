//
//  FundsInteractor.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 02/03/20.
//  Copyright © 2020 Hugo. All rights reserved.
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
        self.worker = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorSalary)
    }
    
    // MARK: - DI -
    static func make(presenter: FundsInteractorToPresenter) -> FundsPresenterToInteractor {
        return FundsInteractor.init(presenter: presenter)
    }
    
    func getFundsCalculatedFromDataBase() -> Double {
        var funds = 0.0
        self.blFinancial.getUsefullyFundsRecalculated(usefullyFund: { (usefully) in
            funds = usefully
        }) { (error) in
            funds = 0.0
        }
        return funds
    }
    
    func getUsefullyFunds() -> Double {
        return self.blFinancial.getUsefullyFunds()
    }
    
    func getDailyValueAvailableFromDataBase() -> Double {
        let usefullyValue: Double = self.getUsefullyFunds()
        let daysLeft: Double = Date().getDaysLeftFromMonth()
        let totalExpense: Double = self.blFinancial.getTotalConstantAndDailyExpense()
        return Double((usefullyValue - totalExpense) / daysLeft).rounded()
    }
    
    func getAlreadyUsedValueFromDataBase() -> Double {
        return self.blFinancial.getTotalConstantAndDailyExpense()
    }
    
    func playAnimationByCurrentBudgetState(happyAnimation: @escaping () -> Void, sadAnimation: @escaping () -> Void) {
        guard self.isUserAlreadySubmitedAllInformations() else { return }
        self.blFinancial.getUsefullyFundsRecalculated(usefullyFund: { (budget) in
            guard budget > 0 else { sadAnimation(); return }
            happyAnimation()
        }) { (error) in
            assertionFailure()
        }
    }
    
    func isUserAlreadySubmitedAllInformations() -> Bool {
        guard self.blFinancial.getTotalConstantAndDailyExpense() > 0,
            self.blFinancial.getUsefullyFunds() != 0.0 else { return false }
        return true
    }
}


