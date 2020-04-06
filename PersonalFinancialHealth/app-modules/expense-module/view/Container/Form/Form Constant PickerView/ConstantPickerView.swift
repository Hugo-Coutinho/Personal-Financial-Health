//
//  ConstantPickerView.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 09/09/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import Foundation
import UIKit
import AwesomeStackView

class ConstantPickerView: UIView {
    
    // MARK: - OUTLET -
    @IBOutlet weak var monthsPickerView: UIPickerView!
    @IBOutlet weak var constantPickerView: UIView!
    
    // MARK: - DECLARATIONS -
    private lazy var pickerViewType: [String] = [
        NSLocalizedString(Constant.view.expenseView.constantExpense, comment: ""),
        NSLocalizedString(Constant.view.expenseView.dailyExpense, comment: ""),
    ]
    
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
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerViewType[row]
    }
}

// MARK: - IMPLEMENTS PROTOCOL EXPENSE SUBVIEWS -
extension ConstantPickerView: IExpenseSubView {
    func didSelectRow(mainStack: AwesomeStackView) {
        
    }
    
    func instanceExpenseSubViewFromNib() -> UIView {
        return ConstantPickerView.instanceFromNib(nibName: Constant.view.expenseView.expensePickerView)
    }
}

