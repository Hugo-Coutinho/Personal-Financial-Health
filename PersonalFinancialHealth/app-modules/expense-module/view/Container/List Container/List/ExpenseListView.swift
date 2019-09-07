//
//  ExpenseListView.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 04/08/19.x
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import UIKit

class ExpenseListSectionView: UIView {
    
    @IBOutlet weak var sectionView: UIView!
    
    override func layoutSubviews() {
        let aspect = configureAspectRatio(toItem: self, multiplierFirst: 25.0, multiplierSecond: 68.0)
        self.addConstraint(aspect)
    }
}

class ExpenseListItemView: UIView {
    
    @IBOutlet weak var itemText: UILabel!
    @IBOutlet weak var itemBackgroundView: UIView!
    @IBOutlet weak var subItemStackView: UIStackView!
    
    override func layoutSubviews() {
        self.itemText.text = "GAME"
    }
    
    public func configureSubItems() {
        let subItem = ExpenseListSubItemView.instanceFromNib(nibName: "ExpenseListView", index: 2)
        let subItem2 = ExpenseListSubItemView.instanceFromNib(nibName: "ExpenseListView", index: 2)
        let subItem3 = ExpenseListSubItemView.instanceFromNib(nibName: "ExpenseListView", index: 2)
        let subItem4 = ExpenseListSubItemView.instanceFromNib(nibName: "ExpenseListView", index: 2)
        let subItem5 = ExpenseListSubItemView.instanceFromNib(nibName: "ExpenseListView", index: 2)
        let subItem6 = ExpenseListSubItemView.instanceFromNib(nibName: "ExpenseListView", index: 2)
        
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

class ExpenseListSubItemView: UIView {
    override func layoutSubviews() {
//        let aspect = configureAspectRatio(toItem: self, multiplierFirst: 25.0, multiplierSecond: 144.0)
//        self.addConstraint(aspect)
    }
}
