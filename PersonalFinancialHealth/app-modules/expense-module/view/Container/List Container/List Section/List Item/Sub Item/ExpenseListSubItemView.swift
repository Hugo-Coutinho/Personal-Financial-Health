//
//  ExpenseListSubItemView.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 07/09/19.
//  Copyright © 2019 Hugo. All rights reserved.
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
        self.expendedLabel.text = String.localizedStringWithFormat(expendedFormatString, expense)
        return self
    }
}

// MARK: - AUX METHODS -
extension ExpenseListSubItemView {
    func getDate(date: Date) -> String {
        return date.getFormattedDate()
    }
}
