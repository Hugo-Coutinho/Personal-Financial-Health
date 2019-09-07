//
//  ExpenseContainerView.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 02/08/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import UIKit

class ExpenseContainerView: UIView {
    
    @IBOutlet weak var containerStackView: UIStackView!
    
    override func awakeFromNib() {
        self.containerStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        let expenseView = ExpenseListItemView.instanceFromNib(nibName: "ExpenseListView", index: 1)
        self.containerStackView.addArrangedSubview(expenseView)
    }
}
