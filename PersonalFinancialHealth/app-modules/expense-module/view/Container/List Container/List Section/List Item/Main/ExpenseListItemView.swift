//
//  ExpenseListItemView.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 07/09/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit

class ExpenseListItemView: UIView {
    
    @IBOutlet weak var itemText: UILabel!
    @IBOutlet weak var itemBackgroundView: UIView!
    @IBOutlet weak var subItemStackView: UIStackView!
    
    override func layoutSubviews() {
        self.itemText.text = "GAME"
    }
    
    public func configureSubItems() {
        let subItem = ExpenseListSubItemView.instanceFromNib(nibName: "ExpenseListSubItemView")
        let subItem2 = ExpenseListSubItemView.instanceFromNib(nibName: "ExpenseListSubItemView")
        let subItem3 = ExpenseListSubItemView.instanceFromNib(nibName: "ExpenseListSubItemView")
        let subItem4 = ExpenseListSubItemView.instanceFromNib(nibName: "ExpenseListSubItemView")
        let subItem5 = ExpenseListSubItemView.instanceFromNib(nibName: "ExpenseListSubItemView")
        let subItem6 = ExpenseListSubItemView.instanceFromNib(nibName: "ExpenseListSubItemView")
        
        self.subItemStackView.addArrangedSubview(subItem)
        self.subItemStackView.addArrangedSubview(subItem2)
        self.subItemStackView.addArrangedSubview(subItem3)
        self.subItemStackView.addArrangedSubview(subItem4)
        self.subItemStackView.addArrangedSubview(subItem5)
        self.subItemStackView.addArrangedSubview(subItem6)
        self.layoutIfNeeded()
        self.subItemStackView.layoutIfNeeded()
        
        
        //        let currentHeight = self.frame.height
        //        let newHeight = (currentHeight + self.subItemStackView.frame.height)
        //        self.heightAnchor.constraint(equalToConstant: newHeight).isActive = true
    }
}
