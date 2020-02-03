//
//  ExpenseListSectionView.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 07/09/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit

class ExpenseListSectionView: UIView {
    
    // MARK: - OUTLET -
    @IBOutlet weak var sectionView: UIView!
    @IBOutlet weak var itemMainStackView: StackViewController!
    
    // MARK: - VARIABLE -
    private lazy var arrangedSubviews: [IExpenseSubView] = [
    ]
    
    // MARK: - OVERRIDE -
    override func awakeFromNib() {
        self.itemMainStackView.dataSource = self
        self.itemMainStackView.initialize()
        self.addGestureRecognizer()
        self.itemMainStackView.isHidden = true
    }
}

// MARK: - STACKVIEW DATASOURCE -
extension ExpenseListSectionView: StackViewDataSource {
    func stackView(_ stackView: UIStackView, numberOfRowsInSection section: Int) -> Int {
        return self.arrangedSubviews.count
    }
    
    func stackView(_ stackView: UIStackView, customSpacingForRow index: Int) -> Int {
        return 0
    }
    
    func stackView(_ stackView: UIStackView, viewForRowAt index: Int) -> UIView {
        guard self.currentViewExist(index: index) else { return UIView() }
        return self.arrangedSubviews[index].instanceExpenseSubViewFromNib()
    }
}

// MARK: - MICRO FUNCTIONS -
extension ExpenseListSectionView {
    private func currentViewExist(index: Int) -> Bool {
        return self.arrangedSubviews.count >= index
    }
    
    private func addGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didSelectSection))
        self.sectionView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didSelectSection() {
        guard self.subViewItemsIsHidden() else { self.removeSubItems(); return }
        self.showSubItems()
    }
    
    private func subViewItemsIsHidden() -> Bool {
        return self.itemMainStackView.arrangedSubviews.isEmpty
    }
    
    private func showSubItems() {
        self.itemMainStackView.isHidden = false
        self.itemMainStackView.addChildView(childView: ExpenseListItemView.instanceFromNib(nibName: Constant.view.expenseView.expenseListItem), at: 0)
        self.itemMainStackView.addChildView(childView: ExpenseListItemView.instanceFromNib(nibName: Constant.view.expenseView.expenseListItem), at: 1)
        self.itemMainStackView.addChildView(childView: ExpenseListItemView.instanceFromNib(nibName: Constant.view.expenseView.expenseListItem), at: 2)
    }
    
    private func removeSubItems() {
        self.itemMainStackView.isHidden = true
        self.itemMainStackView.removeAll()
    }
}

// MARK: - IMPLEMENTS INTERFACE -
extension ExpenseListSectionView: IExpenseContainerSubView {
    func instanceExpenseContainerSubViewFromNib() -> UIView {
        return ExpenseListSectionView.instanceFromNib(nibName: Constant.view.expenseView.expenseSection)
    }
}

