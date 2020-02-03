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
    
    @IBOutlet weak var confirmView: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    
    
    override func layoutSubviews() {
        self.addConstraint(configureAspectRatio(toItem: self.confirmView, multiplierFirst: 5.0, multiplierSecond: 25.0))
        self.confirmButton.layer.cornerRadius = self.confirmButton.layer.bounds.size.height / 2
    }
}

// MARK: - IMPLEMENTS PROTOCOL EXPENSE SUBVIEWS -
extension ConfirmView: IExpenseSubView {
    func didSelectRow() {
        
    }
    
    func instanceExpenseSubViewFromNib() -> UIView {
        return ConfirmView.instanceFromNib(nibName: Constant.view.expenseView.expenseConfirmButton)
    }
}

