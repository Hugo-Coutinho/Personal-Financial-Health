//
//  HistoricalContainerView.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 27/03/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import UIKit

class HistoricalContainerView: UIView {
    
    // MARK: - OVERRIDE LIFE CYCLE -
    override func awakeFromNib() {
        
    }
}

// MARK: - IMPLEMENTS PROTOCOL -
extension HistoricalContainerView: IHistoricalView {
    func instanceExpenseSubViewFromNib() -> UIView {
        return HistoricalContainerView.instanceFromNib(nibName: Constant.view.historicalView.historicalContainerView)
    }
    
    func didSelectRow(mainStack: StackViewController) {
        
    }
}

