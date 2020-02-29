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
    
    override func layoutSubviews() {
        GestureRecognizer.addGesture(view: self.reusableButton, target: self, action: #selector(self.saveExpense(_:)))
    }
}

// MARK: - AUX METHODS -
extension ConfirmView {
    @objc private func saveExpense(_ sender: Any) {
        print("confirm view button clicked")
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

