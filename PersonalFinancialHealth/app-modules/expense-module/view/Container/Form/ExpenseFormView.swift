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
    
    @IBOutlet weak var monthsPickView: UIPickerView!
    @IBOutlet weak var constantExpensePickerView: UIView!
    @IBOutlet weak var headerConstantExpenseView: UIView!
    @IBOutlet weak var ivDownArrow: UIImageView!
    
    private lazy var constantViewIsOpen: Bool = false
    
    override func awakeFromNib() {
        self.constantExpensePickerView.isHidden = true
        self.monthsPickView.delegate = self
        self.monthsPickView.dataSource = self
    }
}

extension ExpenseFormView: UIPickerViewDelegate {
    
}

extension ExpenseFormView: UIPickerViewDataSource {
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

extension ExpenseFormView {
    func ConstantExpenseVisibility() {
        guard !self.constantViewIsOpen else { self.closeConstantExpense(); return }
        self.openConstantExpense()
    }
    
    func closeConstantExpense() {
        UIView.animate(withDuration:0.2, animations: { () -> Void in
            self.ivDownArrow.transform = CGAffineTransform(rotationAngle: CGFloat(CGFloat(Double.pi)))
            self.constantExpensePickerView.alpha = 1
        })
        UIView.animate(withDuration: 0.2, delay: 0.15, options: .curveEaseIn, animations: { () -> Void in
            self.ivDownArrow.transform = CGAffineTransform(rotationAngle: CGFloat(CGFloat(Double.pi * 2)))
            self.constantExpensePickerView.alpha = 0.7
        }) { (isAnimationComplete) in
            self.constantExpensePickerView.alpha = 0.3
        }
        self.constantExpensePickerView.isHidden = true
        self.constantExpensePickerView.alpha = 0
        self.constantViewIsOpen = false
    }
    
    private func openConstantExpense() {
        self.constantExpensePickerView.isHidden = false
        UIView.animate(withDuration:0.2, animations: { () -> Void in
            self.ivDownArrow.transform = CGAffineTransform(rotationAngle: CGFloat(CGFloat(Double.pi)))
            self.constantExpensePickerView.alpha = 0
        })
        UIView.animate(withDuration: 0.2, delay: 0.15, options: .curveEaseIn, animations: { () -> Void in
            self.ivDownArrow.transform = CGAffineTransform(rotationAngle: CGFloat(CGFloat(Double.pi)))
            self.constantExpensePickerView.alpha = 0.5
        }) { (isAnimationComplete) in
            self.constantExpensePickerView.alpha = 1
        }
        self.constantViewIsOpen = true
    }
}

