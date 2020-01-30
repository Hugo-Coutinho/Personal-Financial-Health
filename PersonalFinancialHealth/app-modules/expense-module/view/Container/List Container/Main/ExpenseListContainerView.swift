//
//  ExpenseListContainerView.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 23/08/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit

class ExpenseListContainerView: UIView {
    
    // MARK: - OUTLET -
    @IBOutlet weak var listContainerStackView: StackViewController!
    
    // MARK: - OUTLET -
    private lazy var arrangedSubviews: [IExpenseSubView] = [
    ExpenseListItemView()
    ]
    
    // MARK: - OVERRIDE -
    override func awakeFromNib() {
        self.listContainerStackView.dataSource = self
        self.listContainerStackView.initialize()
    }
}

// MARK: - STACKVIEW DATASOURCE -
extension ExpenseListContainerView: StackViewDataSource {
    func stackView(_ stackView: UIStackView, customSpacingForRow index: Int) -> Int {
        return 0
    }
    
    func stackView(_ stackView: UIStackView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func stackView(_ stackView: UIStackView, viewForRowAt index: Int) -> UIView {
        return self.arrangedSubviews[0].instanceExpenseSubViewFromNib()
    }
}

// MARK: - IMPLEMENTS PROTOCOL EXPENSE SUBVIEWS -
extension ExpenseListContainerView: IExpenseSubView {
    func instanceExpenseSubViewFromNib() -> UIView {
        return ExpenseListContainerView.instanceFromNib(nibName: Constant.view.expenseView.expenseListcontainer)
    }
}

