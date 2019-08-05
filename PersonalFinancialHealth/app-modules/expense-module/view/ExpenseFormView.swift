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
    
    override func awakeFromNib() {
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

