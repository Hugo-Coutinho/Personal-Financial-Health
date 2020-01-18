//
//  ExpenseFormView.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 09/09/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit
import Foundation


class ExpenseFormView: UIView {
    
    @IBOutlet weak var formStackView: UIStackView!
    
    override func layoutSubviews() {
        self.addConstraint(configureAspectRatio(toItem: self.formStackView, multiplierFirst: 2.0, multiplierSecond: 4.0))
    }
}

// MARK: - IMPLEMENTS PROTOCOL EXPENSE SUBVIEWS -
extension ExpenseFormView: IExpenseSubView {
    func instanceExpenseSubViewFromNib() -> UIView {
        return ExpenseFormView.instanceFromNib(nibName: Constant.view.expenseView.expenseFormView)
    }
}
