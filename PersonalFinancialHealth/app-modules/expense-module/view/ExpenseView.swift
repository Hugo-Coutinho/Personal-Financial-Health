//
//  ExpenseView.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 22/07/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit

class ExpenseView: UIView {

    @IBOutlet weak var sectionView: UIView!
    @IBOutlet weak var itemView: UIView!
    
    override func awakeFromNib() {
        self.itemView.isHidden = true
        self.sectionView.isHidden = true
    }
}
