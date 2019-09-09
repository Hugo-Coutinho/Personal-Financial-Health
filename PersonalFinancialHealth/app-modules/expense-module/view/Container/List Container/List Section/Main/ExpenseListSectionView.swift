//
//  ExpenseListSectionView.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 07/09/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit

class ExpenseListSectionView: UIView {
    
    @IBOutlet weak var sectionView: UIView!
    
    override func layoutSubviews() {
        let aspect = configureAspectRatio(toItem: self, multiplierFirst: 25.0, multiplierSecond: 68.0)
        self.addConstraint(aspect)
    }
}
