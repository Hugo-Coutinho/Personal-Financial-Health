//
//  ConstantPickerView.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 09/09/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import UIKit

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

// MARK: - IMPLEMENTS PROTOCOL EXPENSE SUBVIEWS -
extension ConstantPickerView: IExpenseSubView {
    func didSelectRow() {
        
    }
    
    func instanceExpenseSubViewFromNib() -> UIView {
        return ConstantPickerView.instanceFromNib(nibName: Constant.view.expenseView.expensePickerView)
    }
}

