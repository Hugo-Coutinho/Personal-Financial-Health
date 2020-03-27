//
//  ConstantCollapseView.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 09/09/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import UIKit

class ConstantCollapseView: UIView {
    
    // MARK: - OUTLET -
    @IBOutlet weak var ivDownArrow: UIImageView!
    @IBOutlet weak var constantCollapseView: UIView!
    @IBOutlet weak var expenseTypeLabel: UILabel!
    
    // MARK: - PROPERTIES -     
    private lazy var mainStack: StackViewController = self.getExpenseArrangedSubViews()
    
    override func layoutSubviews() {
        self.expenseTypeLabel.text = NSLocalizedString("expenseTypeLabel", comment: "")
        self.ivDownArrow.isHidden = false
        self.openConstantExpense()
        self.addConstraint(configureAspectRatio(toItem: self.constantCollapseView, multiplierFirst: 1.0, multiplierSecond: 7.0))
    }
    
    func closeConstantExpense() {
        UIView.animate(withDuration: 0.2, delay: 0.15, options: .curveEaseIn, animations: { () -> Void in
            self.ivDownArrow.transform = CGAffineTransform(rotationAngle: CGFloat(CGFloat(Double.pi * 2)))
        }) { (isAnimationComplete) in
        }
    }
    
    func openConstantExpense() {
        UIView.animate(withDuration:0.2, animations: { () -> Void in
            self.ivDownArrow.transform = CGAffineTransform(rotationAngle: CGFloat(CGFloat(Double.pi)))
        })
        UIView.animate(withDuration: 0.2, delay: 0.15, options: .curveEaseIn, animations: { () -> Void in
            self.ivDownArrow.transform = CGAffineTransform(rotationAngle: CGFloat(CGFloat(Double.pi)))
        }) { (isAnimationComplete) in
        }
    }
}

// MARK: - IMPLEMENTS PROTOCOL EXPENSE SUBVIEWS -
extension ConstantCollapseView: IExpenseSubView {
    func didSelectRow(mainStack: StackViewController) {
        self.didSelectCollapseView()
    }
    
    func instanceExpenseSubViewFromNib() -> UIView {
        return ConstantCollapseView.instanceFromNib(nibName: Constant.view.expenseView.expenseCollapseView)
    }
}

// MARK: - AUX FUNCTIONS -
extension ConstantCollapseView {
    private func getExpenseArrangedSubViews() -> StackViewController {
        guard let expenseViewController = UIViewController.getVisibileViewController(viewController: ExpenseViewController.self) else { return StackViewController() }
        return expenseViewController.mainStackView
    }
    
    private func didSelectCollapseView() {
        guard self.subViewPickerViewIsHidden() else { return self.hiddenPickerView(collapseView: self.getCollapseViewFromMainStackView()) }
        self.addSubviewPickerView(collapseView: self.getCollapseViewFromMainStackView())
    }
    
    private func subViewPickerViewIsHidden() -> Bool {
        let subViewPositionTwo =  self.mainStack.arrangedSubviews[expenseSubViewEnum.pickerView.getIndex()]
        return !(subViewPositionTwo is ConstantPickerView)
    }
    
    private func getCollapseViewFromMainStackView() -> ConstantCollapseView? {
        return self.mainStack.arrangedSubviews[expenseSubViewEnum.collapse.getIndex()] as? ConstantCollapseView
    }
    
    private func addSubviewPickerView(collapseView: ConstantCollapseView?) {
        collapseView?.openConstantExpense()
        self.mainStack.addChildView(childView: ConstantPickerView.instanceFromNib(nibName: Constant.view.expenseView.expensePickerView), at: expenseSubViewEnum.pickerView.getIndex())
    }
    
    private func hiddenPickerView(collapseView: ConstantCollapseView?) {
        collapseView?.closeConstantExpense();
        self.mainStack.removeChild(at: expenseSubViewEnum.pickerView.getIndex())
        return
    }
}
