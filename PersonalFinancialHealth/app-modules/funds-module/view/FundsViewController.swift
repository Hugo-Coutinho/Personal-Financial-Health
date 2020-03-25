//
//  FundsViewController.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 02/03/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import UIKit

class FundsViewController: UIViewController {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var fundsLabel: UILabel!
    @IBOutlet weak var valueUsedDailyLabel: UILabel!
    @IBOutlet weak var valueAlreadyUsedLabel: UILabel!
    
    // MARK: - PROPERTIES -
    private lazy var presenter: FundsPresenterInput = FundsPresenter.make(view: self)
    private lazy var worker: CoreDataWorkerInput = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorExpense)
    
    // MARK: - LIFE CYCLE -
    override func viewWillAppear(_ animated: Bool) {
        self.loadFunds()
    }
    
    private func loadFunds() {
        self.fundsLabel.text = self.presenter.fetchFunds()
        self.valueUsedDailyLabel.text = self.presenter.fetchDailyValue()
        self.valueAlreadyUsedLabel.text = ""
    }
}

extension FundsViewController: FundsPresenterToView {
    
}


