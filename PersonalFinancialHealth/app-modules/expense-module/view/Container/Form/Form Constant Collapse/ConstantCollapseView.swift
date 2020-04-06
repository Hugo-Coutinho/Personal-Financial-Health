//
//  ConstantCollapseView.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 09/09/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import Foundation
import UIKit
import AwesomeStackView

class ConstantCollapseView: UIView {
    
    // MARK: - OUTLET -
    @IBOutlet weak var ivDownArrow: UIImageView!
    @IBOutlet weak var constantCollapseView: UIView!
    @IBOutlet weak var expenseTypeLabel: UILabel!
    
    // MARK: - PROPERTIES -     
    private lazy var mainStack: AwesomeStackView = self.getExpenseArrangedSubViews()
    
    override func layoutSubviews() {
        self.showArrowClosingCollapseAnimation()
        self.expenseTypeLabel.text = NSLocalizedString("expenseTypeLabel", comment: "")
        self.addConstraint(configureAspectRatio(toItem: self.constantCollapseView, multiplierFirst: 1.0, multiplierSecond: 7.0))
    }
}

// MARK: - AUX FUNCTIONS -
extension ConstantCollapseView {
    private func getExpenseArrangedSubViews() -> AwesomeStackView {
        guard let expenseViewController = UIViewController.getVisibileViewController(viewController: ExpenseViewController.self) else { return AwesomeStackView() }
        return expenseViewController.mainStackView
    }
    
    private func didSelectCollapseView() {
        guard self.subViewPickerViewIsHidden() else { return self.hiddenPickerView(collapseView: self.getCollapseViewFromMainStackView()) }
        self.ShowPickerView(collapseView: self.getCollapseViewFromMainStackView())
    }
    
    private func subViewPickerViewIsHidden() -> Bool {
        let subViewPositionTwo =  self.mainStack.arrangedSubviews[expenseSubViewEnum.pickerView.getIndex()]
        return !(subViewPositionTwo is ConstantPickerView)
    }
    
    private func getCollapseViewFromMainStackView() -> ConstantCollapseView? {
        return self.mainStack.arrangedSubviews[expenseSubViewEnum.collapse.getIndex()] as? ConstantCollapseView
    }
    
    private func ShowPickerView(collapseView: ConstantCollapseView?) {
        collapseView?.showArrowOpeningCollapseAnimation()
        self.mainStack.addChildView(childView: ConstantPickerView.instanceFromNib(nibName: Constant.view.expenseView.expensePickerView), at: expenseSubViewEnum.pickerView.getIndex())
    }
    
    private func hiddenPickerView(collapseView: ConstantCollapseView?) {
        guard !self.mainStack.arrangedSubviews.filter({ $0 is ConstantPickerView }).isEmpty,
            let pickerViewInstance = self.mainStack.arrangedSubviews.first(where: { $0 is ConstantPickerView }),
            let pickerViewIndex = self.mainStack.arrangedSubviews.firstIndex(of: pickerViewInstance) else { return }
        collapseView?.showArrowClosingCollapseAnimation();
        self.mainStack.removeChild(at: pickerViewIndex)
    }
}

// MARK: - COLLAPSE ANIMATION FUNCTIONS -
extension ConstantCollapseView {
    private func showArrowClosingCollapseAnimation() {
        UIView.animate(withDuration: 0.2, delay: 0.15, options: .curveEaseIn, animations: { () -> Void in
            self.ivDownArrow.transform = CGAffineTransform(rotationAngle: CGFloat(CGFloat(Double.pi  * 1.5)))
        }) { (isAnimationComplete) in
        }
    }
    
    private func showArrowOpeningCollapseAnimation() {
        UIView.animate(withDuration:0.2, animations: { () -> Void in
            self.ivDownArrow.transform = CGAffineTransform(rotationAngle: CGFloat(CGFloat(Double.pi * 2)))
        })
        UIView.animate(withDuration: 0.2, delay: 0.15, options: .curveEaseIn, animations: { () -> Void in
            self.ivDownArrow.transform = CGAffineTransform(rotationAngle: CGFloat(CGFloat(Double.pi * 2)))
        }) { (isAnimationComplete) in
        }
    }
}

// MARK: - IMPLEMENTS PROTOCOL EXPENSE SUBVIEWS -
extension ConstantCollapseView: IExpenseSubView {
    func didSelectRow(mainStack: AwesomeStackView) {
        self.didSelectCollapseView()
    }
    
    func instanceExpenseSubViewFromNib() -> UIView {
        return ConstantCollapseView.instanceFromNib(nibName: Constant.view.expenseView.expenseCollapseView)
    }
}

