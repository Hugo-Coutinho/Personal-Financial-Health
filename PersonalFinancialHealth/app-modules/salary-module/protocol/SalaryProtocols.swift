//
//  SalaryProtocols.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 20/02/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import Foundation

// MARK: - PRESENTER INPUT -
protocol SalaryViewToPresenter {
    var view: SalaryPresenterToView {get set}
    var interactor: SalaryPresenterToInteractor? {get set}
}

// MARK: - PRESENTER OUTPUT -
protocol SalaryPresenterToView {
    func updateNetSalaryLabel()
    func showFailToSaveSalaryAlert()
    func didNotLoadNetSalary()
    func didLoadNetSalary(net: Double)
    func invalidInput()
    func validInput()
}

// MARK: - INTERACTOR INPUT -
protocol SalaryPresenterToInteractor {
    var presenter: SalaryInteractorToPresenter {get set}
    static func make(presenter: SalaryInteractorToPresenter) -> SalaryPresenterToInteractor
    func fetchNetSalary(net: SalaryModel)
    func loadNetSalary() -> Double?
}

// MARK: - INTERACTOR OUTPUT -
protocol SalaryInteractorToPresenter {
    func didSaveSalary()
    func didFailToSaveSalary()
}


