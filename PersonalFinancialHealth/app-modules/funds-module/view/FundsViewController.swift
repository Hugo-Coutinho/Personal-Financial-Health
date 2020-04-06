//
//  FundsViewController.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 02/03/20.
//  Copyright © 2020 Hugo. All rights reserved.
//

import UIKit
import Lottie

class FundsViewController: UIViewController {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var fundsLabel: UILabel!
    @IBOutlet weak var valueUsedDailyLabel: UILabel!
    @IBOutlet weak var valueAlreadyUsedLabel: UILabel!
    @IBOutlet weak var expensesStateAnimation: AnimationView!
    @IBOutlet weak var expensesStateMessageLabel: UILabel!
    
    // MARK: - PROPERTIES -
    private lazy var presenter: FundsPresenterInput = FundsPresenter.make(view: self)
    private lazy var worker: CoreDataWorkerInput = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorExpense)
    
    // MARK: - LIFE CYCLE -
    override func viewWillAppear(_ animated: Bool) {
        self.hiddenExpenseAnimation()
        self.presenter.checkUserBudgetState()
        self.loadFunds()
    }
    
    private func hiddenExpenseAnimation() {
        self.expensesStateAnimation.isHidden = true
        self.expensesStateMessageLabel.isHidden = true
    }
    
    private func UnhiddenExpenseAnimation() {
        self.expensesStateAnimation.isHidden = false
        self.expensesStateMessageLabel.isHidden = false
    }
    
    func playAnimation(named: String, LocalizedmMessage: String) {
        self.expensesStateMessageLabel.text = NSLocalizedString(LocalizedmMessage, comment: "")
        self.expensesStateAnimation.animation = Animation.named(named)
        self.expensesStateAnimation.loopMode = .playOnce
        self.expensesStateAnimation.contentMode = .scaleAspectFill
        self.expensesStateAnimation.play()
    }
    
    private func loadFunds() {
        let fundsFormatString = NSLocalizedString("fundsLabel", comment: "fundsLabel")
        let valueUsedDailyFormatString = NSLocalizedString("valueUsedDailyLabel", comment: "valueUsedDailyLabel")
        let valueAlreadyUsedFormatString = NSLocalizedString("valueAlreadyUsedLabel", comment: "valueAlreadyUsedLabel")
        
        self.fundsLabel.text = String.localizedStringWithFormat(fundsFormatString, self.presenter.fetchFunds())
        self.valueUsedDailyLabel.text = String.localizedStringWithFormat(valueUsedDailyFormatString, self.presenter.fetchDailyValue())
        self.valueAlreadyUsedLabel.text = String.localizedStringWithFormat(valueAlreadyUsedFormatString, self.presenter.fetchAlreadyUsedValue())
    }
}

// MARK: - PRESENTER OUTPUT -
extension FundsViewController: FundsPresenterToView {
    func playHappyAnimation() {
        self.UnhiddenExpenseAnimation()
        self.playAnimation(named: Constant.view.fundsView.BudgetIsGreenAnimation, LocalizedmMessage: "budgetIsGreateMessage")
    }
    
    func playSadAnimation() {
        self.UnhiddenExpenseAnimation()
        self.playAnimation(named: Constant.view.fundsView.BudgetIsBlackAnimation, LocalizedmMessage: "budgetIsNotGoingWell")
    }
}


