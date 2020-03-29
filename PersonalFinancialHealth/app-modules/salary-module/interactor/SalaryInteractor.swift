//
//  SalaryInteractor.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 20/02/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import Foundation

// MARK: - INTERACTOR INPUT -
protocol SalaryInteractorInput {
    static func make(presenter: SalaryInteractorToPresenter) -> SalaryPresenterToInteractor
}

class SalaryInteractor: SalaryInteractorInput, SalaryPresenterToInteractor {
    
    // MARK: - PROPERTIES -
    var worker: CoreDataWorkerInput
    var presenter: SalaryInteractorToPresenter
    
    // MARK: - INITIALIZER -
    init(presenter: SalaryInteractorToPresenter) {
        self.presenter = presenter
        self.worker  = CoreDataWorker.make(sortDescriptionKey: ConstantPersistence.sortDescriptorSalary)
    }
    
    // MARK: - DI -
    static func make(presenter: SalaryInteractorToPresenter) -> SalaryPresenterToInteractor {
        return SalaryInteractor.init(presenter: presenter)
    }
    
    func fetchNetSalary(net: SalaryModel) {
        let managedObject = self.worker.read(manageObjectType: SalaryMO.self)
        guard let wrappedValue = managedObject?.first else { self.createNetSalary(net: net); return }
        self.updateNetSalary(net: net, wrappedValue: wrappedValue)
    }
    
    func createNetSalary(net: SalaryModel) {
        do {
            try self.worker.create(entity: net.toManagedObject(in: worker.context))
            self.presenter.didSaveSalary()
        } catch  {
            self.presenter.didFailToSaveSalary()
        }
    }
    
    func updateNetSalary(net: SalaryModel, wrappedValue: SalaryMO) {
        wrappedValue.setValue(net.net, forKey: "net")
        wrappedValue.setValue(net.usefully, forKey: "usefully")
        do {
            try self.worker.context.save()
            self.presenter.didSaveSalary()
        } catch  {
            self.presenter.didFailToSaveSalary()
        }
    }
    
    func loadSalary() -> SalaryModel? {
        let managedObject = self.worker.read(manageObjectType: SalaryMO.self)
        guard let wrappedValue = managedObject?.first else { return nil }
        return SalaryModel.toEntity(mo: wrappedValue) 
    }
}
