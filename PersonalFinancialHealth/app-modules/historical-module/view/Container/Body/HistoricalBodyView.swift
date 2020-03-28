//
//  HistoricalBodyView.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 27/03/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import UIKit

class HistoricalBodyView: UIView {
    
    // MARK: - OUTLETS -
    
    
    // MARK: - LIFE CYCLE -
    override func awakeFromNib() {
        //
    }
}


// MARK: - IMPLEMENTS PROTOCOL HISTORICAL VIEWS -
extension HistoricalBodyView: IHistoricalView {
    func didSelectRow(mainStack: StackViewController) {
        
    }
    
    func instanceExpenseSubViewFromNib() -> UIView {
        return ExpenseFormView.instanceFromNib(nibName: Constant.view.expenseView.expenseFormView)
    }
}

