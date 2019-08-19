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
        let expenseView = ExpenseListSectionView.instanceFromNib(nibName: "ExpenseListView")
        self.containerStackView.addArrangedSubview(expenseView)
    }
}
