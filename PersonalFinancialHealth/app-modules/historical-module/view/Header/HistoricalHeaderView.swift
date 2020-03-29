//
//  HistoricalHeaderView.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 27/03/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import UIKit

class HistoricalHeaderView: UIView {

    // MARK: - OUTLETS -
    @IBOutlet weak var lastMonthExpenseValueLabel: UILabel!

    // MARK: - LIFE CYCLE -
    override func awakeFromNib() {
    // get last month valueb
    }
}


// MARK: - IMPLEMENTS PROTOCOL HISTORICAL VIEWS -
extension HistoricalHeaderView: IHistoricalView {
    func instanceHistoricalViewFromNib() -> UIView {
        return HistoricalContainerView.instanceFromNib(nibName: Constant.view.historicalView.historicalHeaderView)
    }
    
    func didSelectHistoricalRow(mainStack: StackViewController) {
        
    }
}
