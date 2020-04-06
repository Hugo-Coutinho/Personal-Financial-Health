//
//  ExpenseContainerView.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 02/08/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import Foundation
import UIKit

class ExpenseContainerView: UIView {
    
    @IBOutlet weak var containerStackView: UIStackView!
    
    override func awakeFromNib() {
        self.containerStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        let expenseView = ExpenseListItemView.instanceFromNib(nibName: "ExpenseListItemView")
        self.containerStackView.addArrangedSubview(expenseView)
    }
}
