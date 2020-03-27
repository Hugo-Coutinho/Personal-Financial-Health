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
        let dateFormatString = NSLocalizedString("dateLabel", comment: "")
        let expendedFormatString = NSLocalizedString("expendedLabel", comment: "")
        
        self.dateLabel.text =  String.localizedStringWithFormat(dateFormatString, self.getDate(date: date))
        self.expendedLabel.text = String.localizedStringWithFormat(expendedFormatString, self.getExpense(expense: expense))
        return self
    }
}

// MARK: - AUX METHODS -
extension ExpenseListSubItemView {
    func getDate(date: Date) -> String {
        return date.getFormattedDate()
    }

    func getExpense(expense: Double) -> String {
        return String(expense).formatValueWithR$()
    }
}
