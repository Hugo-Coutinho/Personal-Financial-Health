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
    
    
    override func layoutSubviews() {
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
    func instanceExpenseSubViewFromNib() -> UIView {
        return ConstantCollapseView.instanceFromNib(nibName: Constant.view.expenseView.expenseCollapseView)
    }
}
