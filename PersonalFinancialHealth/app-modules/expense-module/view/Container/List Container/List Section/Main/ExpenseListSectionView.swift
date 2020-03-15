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
    @IBOutlet weak var totalExpendedLabel: UILabel!
    @IBOutlet weak var expenseTypeLabel: UILabel!
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
    
    // MARK: - MAKE VIEW -
    public func setupSectionView(sectionView: ExpenseListSectionView, itemModel: [ExpenseItemModel], index: Int) -> ExpenseListSectionView {
        let defaultTotal = "R$ 00,00"
        var totalExpended: String = ""
        totalExpended = self.getTotalExpended(sectionView: sectionView, itemModel: itemModel, index: index)
        sectionView.totalExpendedLabel.text = defaultTotal.replace("00,00", withString: totalExpended)
        sectionView.expenseTypeLabel.text = self.getExpenseType(sectionView: sectionView, itemModel: itemModel, index: index) == 0 ? "Constant Expense" : "Daily Expense"
        return sectionView
    }
}

// MARK: - AUX METHODS -
extension ExpenseListSectionView {
    // - pega o index da secao
    // - é zero -> possui gasto constante -> retorna gasto constante.
    // - é zero -> nao possui gasto constate -> retorna gasto diario.
    // - é um -> apresenta gasto diario.
    
    private func getTotalExpended(sectionView: ExpenseListSectionView, itemModel: [ExpenseItemModel], index: Int) -> String {
        if index == 0 && itemModel.filter({ $0.expenseType == 0 }).count > 0 {
            return String(itemModel.filter({ $0.expenseType == 0 }).map({ $0.subItems.map({ $0.expended }).reduce(0, +) }).reduce(0, +))
        } else if index == 0 && itemModel.filter({ $0.expenseType == 1 }).count > 0 {
            return String(itemModel.filter({ $0.expenseType == 1 }).map({ $0.subItems.map({ $0.expended }).reduce(0, +) }).reduce(0, +))
        }
        return String(itemModel.filter({ $0.expenseType == 1 }).map({ $0.subItems.map({ $0.expended }).reduce(0, +) }).reduce(0, +))
    }
    
    private func getExpenseType(sectionView: ExpenseListSectionView, itemModel: [ExpenseItemModel], index: Int) -> Int {
        if index == 0 && itemModel.filter({ $0.expenseType == 0 }).count > 0 {
            return 0
        } else if index == 0 && itemModel.filter({ $0.expenseType == 1 }).count > 0 {
            return 1
        }
        return 1
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

