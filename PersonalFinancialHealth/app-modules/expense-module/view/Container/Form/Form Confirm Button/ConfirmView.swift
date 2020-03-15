//
//  ConfirmView.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 09/09/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import UIKit

// MARK: - CONFIRM VIEW -
class ConfirmView: UIView {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var reusableButton: ReusableButton!
}

// MARK: - IMPLEMENTS PROTOCOL EXPENSE SUBVIEWS -
extension ConfirmView: IExpenseSubView {
    func didSelectRow(mainStack: StackViewController) {
            guard let formView = mainStack.arrangedSubviews.filter({ $0 is ExpenseFormView }).first else { return }
        (formView as! ExpenseFormView).createNewExpense()
    }
    
    func instanceExpenseSubViewFromNib() -> UIView {
        return ConfirmView.instanceFromNib(nibName: Constant.view.expenseView.expenseConfirmButton)
    }
}

