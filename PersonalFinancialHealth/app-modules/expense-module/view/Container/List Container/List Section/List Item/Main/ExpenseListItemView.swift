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
    @IBOutlet weak var arrowImage: UIImageView!
    @IBOutlet weak var expenseValueLabel: UILabel!
    @IBOutlet weak var subItemMainStackView: StackViewController!
    
    // MARK: - VARIABLE -
    private lazy var arrangedSubviews: [IExpenseSubView] = [
    ]
    private lazy var worker: CoreDataWorkerInput = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorExpense)
    private lazy var blFinancial: BLFinancial = BLFinancial(worker: self.worker)
    
    // MARK: - OVERRIDE -
    override func layoutSubviews() {
        self.subItemMainStackView.delegate = self
        self.subItemMainStackView.dataSource = self
        self.subItemMainStackView.initialize()
        self.addGestureRecognizer()
        self.fetchTotalExpended()
    }
    
    // MARK: - MAKE VIEW -
    func setupItemView(itemModel: ExpenseItemModel) -> ExpenseListItemView {
        self.itemText.text = itemModel.name
        self.arrowImage.image = UIImage(named: itemModel.icon)
        self.expenseValueLabel.text = String(itemModel.subItems.map({ $0.expended }).reduce(0, +))
        return self
    }
}

// MARK: - STACK VIEW DATA SOURCE -
extension ExpenseListItemView: StackViewDataSource {
    func stackView(_ stackView: UIStackView, customSpacingForRow index: Int) -> Int {
        return 0
    }
    
    func stackView(_ stackView: UIStackView, numberOfRowsInSection section: Int) -> Int {
        return self.arrangedSubviews.count
    }
    
    func stackView(_ stackView: UIStackView, viewForRowAt index: Int) -> UIView {
        return ExpenseListSubItemView.instanceFromNib(nibName: Constant.view.expenseView.expenseListSubitem)
    }
}

// MARK: - STACKVIEW DELEGATE -
extension ExpenseListItemView: StackViewDelegate {

}

// MARK: - MICRO FUNCTIONS -
extension ExpenseListItemView {
    private func addGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didSelectItem))
        self.itemBackgroundView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didSelectItem() {
        self.animateArrow()
        guard self.subItemsIsHidden() else { self.removeSubItems(); return }
        self.showSubItems()
    }
    
    private func subItemsIsHidden() -> Bool {
        return self.subItemMainStackView.arrangedSubviews.isEmpty
    }
    
    private func showSubItems() {
        self.subItemMainStackView.isHidden = false
        self.subItemMainStackView.addChildView(childView: ExpenseListItemView.instanceFromNib(nibName: Constant.view.expenseView.expenseListSubitem), at: 0)
        self.subItemMainStackView.addChildView(childView: ExpenseListItemView.instanceFromNib(nibName: Constant.view.expenseView.expenseListSubitem), at: 1)
    }
    
    private func removeSubItems() {
        self.subItemMainStackView.isHidden = true
        self.subItemMainStackView.removeAll()
    }
    
    func animateArrow() {
        UIView.animate(withDuration:0.2, animations: { () -> Void in
            self.arrowImage.transform = CGAffineTransform(rotationAngle: CGFloat(CGFloat(Double.pi * 2)))
        })
        UIView.animate(withDuration: 0.2, delay: 0.15, options: .curveEaseIn, animations: { () -> Void in
            self.arrowImage.transform = CGAffineTransform(rotationAngle: CGFloat(CGFloat(Double.pi * 5)))
        }) { (isAnimationComplete) in
        }
    }
    
    private func fetchTotalExpended() {
        self.blFinancial.getExpenses(successExpenses: { (expenses) in
            let totalValue = String(expenses.map({ $0.subItems.map({ $0.expended }).reduce(0, +) }).reduce(0, +))
            let defaultText = "R$ 00,00"
            self.expenseValueLabel.text = defaultText.replace("00,00", withString: totalValue)
        }) { (error) in
            self.expenseValueLabel.text = "R$ 00,00"
        }
    }
    
    private func totalItemExpended(expenses: [ExpenseItemModel]) -> Double {
        return expenses.map({ $0.subItems.map({ $0.expended }).reduce(0, +) }).reduce(0, +)
    }
}

// MARK: - IMPLEMENTS INTERFACE -
extension ExpenseListItemView: IExpenseContainerSubView {
    func instanceExpenseContainerSubViewFromNib() -> UIView {
     return ExpenseListItemView.instanceFromNib(nibName: Constant.view.expenseView.expenseListItem)
    }
}

