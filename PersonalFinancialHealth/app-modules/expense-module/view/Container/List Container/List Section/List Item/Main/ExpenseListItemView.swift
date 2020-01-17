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
    @IBOutlet weak var subItemMainStackView: StackViewController!
    
    override func layoutSubviews() {
        self.itemText.text = "GAME"
        self.subItemMainStackView.delegate = self
        self.subItemMainStackView.dataSource = self
        self.subItemMainStackView.initialize()
    }
    
    public func configureSubItems() {
        self.layoutIfNeeded()
        self.subItemMainStackView.layoutIfNeeded()
    }
}

extension ExpenseListItemView: StackViewDataSource {
    func stackView(_ stackView: UIStackView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func stackView(_ stackView: UIStackView, viewForRowAt index: Int) -> UIView {
        return ExpenseListSubItemView.instanceFromNib(nibName: "ExpenseListSubItemView")
    }
}

extension ExpenseListItemView: StackViewDelegate {

}
