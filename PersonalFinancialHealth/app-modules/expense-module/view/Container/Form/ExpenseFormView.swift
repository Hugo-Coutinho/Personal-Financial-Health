//
//  ExpenseFormView.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 02/08/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import UIKit

// MARK: - EXPENSE FORM VIEW -
class ExpenseFormView: UIView {
    
    
    @IBOutlet weak var formStackView: UIStackView!
    
    override func layoutSubviews() {
        self.addConstraint(configureAspectRatio(toItem: self.formStackView, multiplierFirst: 2.0, multiplierSecond: 4.0))
    }
}

// MARK: - CONSTANT COLLAPSE VIEW -
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

// MARK: - CONSTANT PICKER VIEW -
class ConstantPickerView: UIView {
    
    // MARK: - OUTLET -
    @IBOutlet weak var monthsPickerView: UIPickerView!
    @IBOutlet weak var constantPickerView: UIView!
    
    // MARK: - OVERRIDE -
    override func layoutSubviews() {
        self.monthsPickerView.delegate = self
        self.monthsPickerView.dataSource = self
        self.addConstraint(configureAspectRatio(toItem: self.constantPickerView, multiplierFirst: 5.0, multiplierSecond: 14.0))
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

// MARK: - CONFIRM VIEW -
class ConfirmView: UIView {
    
    @IBOutlet weak var confirmView: UIView!
    @IBOutlet weak var confirmButton: UIButton!
    
    
    override func layoutSubviews() {
       self.addConstraint(configureAspectRatio(toItem: self.confirmView, multiplierFirst: 5.0, multiplierSecond: 25.0))
        self.confirmButton.layer.cornerRadius = self.confirmButton.layer.bounds.size.height / 2
    }
}

