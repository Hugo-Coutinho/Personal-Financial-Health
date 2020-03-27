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
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var expenseValueLabel: UILabel!
    @IBOutlet weak var subItemMainStackView: StackViewController!
    
    // MARK: - VARIABLE -
    private var item: ExpenseItemModel?
//    private lazy var arrangedItens: [ExpenseItemModel] = [
//    ]
    private lazy var worker: CoreDataWorkerInput = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorExpense)
    private lazy var blFinancial: BLFinancial = BLFinancial(worker: self.worker)
    
    // MARK: - OVERRIDE -
    override func layoutSubviews() {
        self.subItemMainStackView.delegate = self
        self.subItemMainStackView.dataSource = self
        self.addGestureRecognizer()
    }
    
    // MARK: - MAKE VIEW -
    func setupItemView(itemModel: ExpenseItemModel) -> ExpenseListItemView {
        let itemTextFormatString = NSLocalizedString("itemText", comment: "")
        let expenseValueFormatString = NSLocalizedString("expenseValueLabel", comment: "")
        
        self.itemText.text = String.localizedStringWithFormat(itemTextFormatString, itemModel.name)
//        self.iconImage.image = UIImage(named: itemModel.icon)
        self.expenseValueLabel.text = String.localizedStringWithFormat(expenseValueFormatString, self.getItemExpense(itemModel: itemModel))
        self.updateArrangedSubItems(itemModel: itemModel)
        return self
    }
}

// MARK: - STACK VIEW DATA SOURCE -
extension ExpenseListItemView: StackViewDataSource {
    func stackView(_ stackView: UIStackView, customSpacingForRow index: Int) -> Int {
        return 0
    }
    
    func stackView(_ stackView: UIStackView, numberOfRowsInSection section: Int) -> Int {
        return self.item?.subItems.count ?? 0
    }
    
    func stackView(_ stackView: UIStackView, viewForRowAt index: Int) -> UIView {
        return self.getViewForRow(indexSubItem: index)
    }
}

// MARK: - STACKVIEW DELEGATE -
extension ExpenseListItemView: StackViewDelegate {

}

// MARK: - STACKVIEW AUX FUNCTIONS -
extension ExpenseListItemView {
private func getViewForRow(indexSubItem: Int) -> UIView {
        guard let item = self.item,
            self.currentViewExist(index: indexSubItem) else { return self.instantiateSubItem() }
        let subItemView = self.instantiateSubItem()
        let subItemViewPrepared = subItemView.setupSubItemView(date: item.subItems[indexSubItem].date, expense: item.subItems[indexSubItem].expended)
        return subItemViewPrepared
    }
}

// MARK: - MICRO FUNCTIONS ANIMATION -
extension ExpenseListItemView {
    private func currentViewExist(index: Int) -> Bool {
        return self.item?.subItems.count ?? 0 >= index
    }
    
    private func instantiateSubItem() -> ExpenseListSubItemView {
        return ExpenseListSubItemView.instanceFromNib(nibName: Constant.view.expenseView.expenseListSubitem) as! ExpenseListSubItemView
    }
    
    private func updateArrangedSubItems(itemModel: ExpenseItemModel) {
        self.item = itemModel
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
}


// MARK: - MICRO FUNCTIONS -
extension ExpenseListItemView {
    func getItemExpense(itemModel: ExpenseItemModel) -> String {
        return String(itemModel.subItems.map({ $0.expended }).reduce(0, +)).formatValueWithR$()
    }
    
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
        self.subItemMainStackView.reloadStackView()
    }
    
    private func removeSubItems() {
        self.subItemMainStackView.isHidden = true
        self.subItemMainStackView.removeAll()
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

