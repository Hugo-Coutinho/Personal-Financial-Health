//
//  ExpenseListView.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 04/08/19.x
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import UIKit

class ExpenseListView: UIView {

    @IBOutlet weak var sectionView: UIView!
    @IBOutlet weak var itemView: UIView!
    
    override func awakeFromNib() {
        self.sectionView.isHidden = false
        self.itemView.isHidden = true
    }
}
