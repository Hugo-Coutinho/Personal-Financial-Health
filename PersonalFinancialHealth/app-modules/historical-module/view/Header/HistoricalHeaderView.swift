//
//  HistoricalHeaderView.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 27/03/20.
//  Copyright © 2020 Hugo. All rights reserved.
//

import UIKit
import AwesomeStackView

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
    
    func didSelectHistoricalRow(mainStack: AwesomeStackView) {
        
    }
}

