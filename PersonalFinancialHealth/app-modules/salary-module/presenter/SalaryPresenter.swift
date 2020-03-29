//
//  SalaryPresenter.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 20/02/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import Foundation

// MARK: - PRESENTER INPUT -
protocol SalaryPresenterInput {
    static func make(view: SalaryPresenterToView) -> SalaryPresenterInput
    func fetchNetSalary(netInputValue: String?, usefullyInputValue: String?)
    func loadNetSalary()
    func validateInputValues(netInputValue: String?, usefullyInputValue: String?)
}

class SalaryPresenter: SalaryPresenterInput, SalaryViewToPresenter {
    
    // MARK: - DECLARATIONS -
    var view: SalaryPresenterToView
    var interactor: SalaryPresenterToInteractor?
    
    // MARK: - INITIALIZER -
    init(view: SalaryPresenterToView) {
        self.view = view
        self.interactor = SalaryInteractor.make(presenter: self)
    }
    
    // MARK: - DI -
    static func make(view: SalaryPresenterToView) -> SalaryPresenterInput {
        return SalaryPresenter.init(view: view)
    }
    
    func fetchNetSalary(netInputValue: String?, usefullyInputValue: String?) {
        self.interactor?.fetchNetSalary(net: SalaryModel(net: self.getNetSalaryFromTextField(netInputValue: netInputValue), usefully: self.getSalaryUsefullyFromTextField(usefullyInputValue: usefullyInputValue)))
    }
    
    func loadNetSalary() {
        guard let interactor = self.interactor,
            let salary = interactor.loadSalary() else { self.view.didNotLoadSalary(); return }
        self.view.didLoadSalary(salary: salary)
    }
    
    func validateInputValues(netInputValue: String?, usefullyInputValue: String?) {
        guard let net = netInputValue,
            let usefullyInputValue = usefullyInputValue,
            let netDoubleValue = Double(net),
            let usefullyDoubleValue = Double(usefullyInputValue),
            ((netDoubleValue > 0 && usefullyDoubleValue > 0) && (usefullyDoubleValue < netDoubleValue )) else { self.view.invalidInput(); return }
        self.view.validInput()
    }
}

// MARK: - AUX FUNCTIONS -
extension SalaryPresenter {
    func getNetSalaryFromTextField(netInputValue: String?) -> Double {
        guard let net = netInputValue,
            let netValue = Double(net) else { return 0.0 }
        return netValue
    }
    
    func getSalaryUsefullyFromTextField(usefullyInputValue: String?) -> Double {
        guard let amount = usefullyInputValue,
            let amountValue = Double(amount) else { return 0.0 }
        return amountValue
    }
    
}

// MARK: - IMPLEMENTS INTERACTOR -
extension SalaryPresenter: SalaryInteractorToPresenter {
    func didSaveSalary() {
        self.view.updateSalaryLabels()
    }
    
    func didFailToSaveSalary() {
     self.view.showFailToSaveSalaryAlert()
    }
}

