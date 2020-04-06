//
//  ConfirmView.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 09/09/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import Foundation
import UIKit
import AwesomeStackView

// MARK: - CONFIRM VIEW -
class ConfirmView: UIView {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var reusableButton: ReusableButton!
    
    // MARK: - OVERRIDE -
    override func layoutSubviews() {
        self.reusableButton.button.setTitle(NSLocalizedString("newExpenseButton", comment: ""), for: .normal)
    }
}

// MARK: - IMPLEMENTS PROTOCOL EXPENSE SUBVIEWS -
extension ConfirmView: IExpenseSubView {
    func didSelectRow(mainStack: AwesomeStackView) {
            guard let formView = mainStack.arrangedSubviews.filter({ $0 is ExpenseFormView }).first else { return }
        (formView as! ExpenseFormView).createNewExpense()
    }
    
    func instanceExpenseSubViewFromNib() -> UIView {
        return ConfirmView.instanceFromNib(nibName: Constant.view.expenseView.expenseConfirmButton)
    }
}

