//
//  SalaryProtocols.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 20/02/20.
//  Copyright © 2020 Hugo. All rights reserved.
//

import Foundation

// MARK: - PRESENTER INPUT -
protocol SalaryViewToPresenter {
    var view: SalaryPresenterToView {get set}
    var interactor: SalaryPresenterToInteractor? {get set}
}

// MARK: - PRESENTER OUTPUT -
protocol SalaryPresenterToView {
    func updateSalaryLabels()
    func showFailToSaveSalaryAlert()
    func didNotLoadSalary()
    func didLoadSalary(salary: SalaryModel)
    func invalidInput()
    func validInput()
}

// MARK: - INTERACTOR INPUT -
protocol SalaryPresenterToInteractor {
    var presenter: SalaryInteractorToPresenter {get set}
    static func make(presenter: SalaryInteractorToPresenter) -> SalaryPresenterToInteractor
    func fetchNetSalary(net: SalaryModel)
    func loadSalary() -> SalaryModel?
}

// MARK: - INTERACTOR OUTPUT -
protocol SalaryInteractorToPresenter {
    func didSaveSalary()
    func didFailToSaveSalary()
}


