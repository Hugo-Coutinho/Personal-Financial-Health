//
//  ExpenseListItemView.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 07/09/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit

class ExpenseListItemView: UIView {
    
    // MARK: - OUTLET -
    @IBOutlet weak var itemText: UILabel!
    @IBOutlet weak var itemBackgroundView: UIView!
    @IBOutlet weak var subItemMainStackView: StackViewController!
    
    // MARK: - OVERRIDE -
    override func layoutSubviews() {
        self.itemText.text = "GAME"
        self.subItemMainStackView.delegate = self
        self.subItemMainStackView.dataSource = self
        self.subItemMainStackView.initialize()
    }
}

// MARK: - STACK VIEW DATA SOURCE -
extension ExpenseListItemView: StackViewDataSource {
    func stackView(_ stackView: UIStackView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func stackView(_ stackView: UIStackView, viewForRowAt index: Int) -> UIView {
        return ExpenseListSubItemView.instanceFromNib(nibName: Constant.view.expenseView.expenseListSubitem)
    }
}

// MARK: - STACKVIEW DELEGATE -
extension ExpenseListItemView: StackViewDelegate {

}

// MARK: - IMPLEMENTS INTERFACE -
extension ExpenseListItemView: IExpenseSubView {
    func instanceExpenseSubViewFromNib() -> UIView {
     return ExpenseListItemView.instanceFromNib(nibName: Constant.view.expenseView.expenseListItem)
    }
}
