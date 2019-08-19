//
//  ExpenseFormView.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 02/08/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import UIKit


class ExpenseFormView: UIView {
    
    
    @IBOutlet weak var formStackView: UIStackView!
    
    override func layoutSubviews() {
        self.addConstraint(NSLayoutConstraint(item: self,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: self.formStackView,
                                              attribute: .width,
                                              multiplier: 2.0 / 4.0,
                                              constant: 0))
    }
}

class ConstantCollapseView: UIView {
    
    // MARK: - OUTLET -
    @IBOutlet weak var ivDownArrow: UIImageView!
    @IBOutlet weak var constantCollapseView: UIView!
    
    
    override func layoutSubviews() {
        self.ivDownArrow.isHidden = false
        self.closeConstantExpense()
        self.addConstraint(NSLayoutConstraint(item: self,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: self.constantCollapseView,
                                              attribute: .width,
                                              multiplier: 1.0 / 7.0,
                                              constant: 0))
    }
    
    func closeConstantExpense() {
        UIView.animate(withDuration:0.2, animations: { () -> Void in
            self.ivDownArrow.transform = CGAffineTransform(rotationAngle: CGFloat(CGFloat(Double.pi)))

        })
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


class ConstantPickerView: UIView {
    
    // MARK: - OUTLET -
    @IBOutlet weak var monthsPickerView: UIPickerView!
    @IBOutlet weak var constantPickerView: UIView!
    
    // MARK: - OVERRIDE -
    override func layoutSubviews() {
        self.monthsPickerView.delegate = self
        self.monthsPickerView.dataSource = self
        self.addConstraint(NSLayoutConstraint(item: self,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: self.constantPickerView,
                                              attribute: .width,
                                              multiplier: 5.0 / 14.0,
                                              constant: 0))
    }
}

extension ConstantPickerView: UIPickerViewDelegate {
    
}

extension ConstantPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 6
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "flaflaflaflaflafla"
    }
}

class ConfirmView: UIView {
    
    @IBOutlet weak var confirmView: UIView!
    
    
    override func layoutSubviews() {
        self.addConstraint(NSLayoutConstraint(item: self,
                                              attribute: .height,
                                              relatedBy: .equal,
                                              toItem: self.confirmView,
                                              attribute: .width,
                                              multiplier: 5.0 / 25.0,
                                              constant: 0))
    }
}

