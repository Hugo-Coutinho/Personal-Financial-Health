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
    @IBOutlet weak var subItemMainStackView: StackViewController!
    
    // MARK: - VARIABLE -
    private lazy var arrangedSubviews: [IExpenseSubView] = [
    ]
    
    // MARK: - OVERRIDE -
    override func layoutSubviews() {
        self.itemText.text = "GAME"
        self.subItemMainStackView.delegate = self
        self.subItemMainStackView.dataSource = self
        self.subItemMainStackView.initialize()
        self.addGestureRecognizer()
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
}

// MARK: - IMPLEMENTS INTERFACE -
extension ExpenseListItemView: IExpenseContainerSubView {
    func instanceExpenseContainerSubViewFromNib() -> UIView {
     return ExpenseListItemView.instanceFromNib(nibName: Constant.view.expenseView.expenseListItem)
    }
}
