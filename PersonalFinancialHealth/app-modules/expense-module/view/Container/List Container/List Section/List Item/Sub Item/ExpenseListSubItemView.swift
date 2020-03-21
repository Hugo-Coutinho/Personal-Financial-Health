//
//  ExpenseListSubItemView.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 07/09/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit

class ExpenseListSubItemView: UIView {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var expendedLabel: UILabel!
    
    
    // MARK: - MAKE VIEW -
    func setupSubItemView(date: Date, expense: Double) -> ExpenseListSubItemView {
        self.dateLabel.text = self.getDate(date: date)
        self.expendedLabel.text = self.getExpense(expense: expense)
        return self
    }
}

// MARK: - AUX METHODS -
extension ExpenseListSubItemView {
    private func getDate(date: Date) -> String {
        return date.getFormattedDate()
    }

    private func getExpense(expense: Double) -> String {
        return String(expense)
    }
}
