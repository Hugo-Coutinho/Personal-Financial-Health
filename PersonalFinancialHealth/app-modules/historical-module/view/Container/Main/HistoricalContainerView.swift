//
//  HistoricalContainerView.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 27/03/20.
//  Copyright © 2020 Hugo. All rights reserved.
//

import UIKit
import AwesomeStackView

class HistoricalContainerView: UIView {
    
    // MARK: - OVERRIDE LIFE CYCLE -
    override func awakeFromNib() {
        
    }
}

// MARK: - IMPLEMENTS PROTOCOL -
extension HistoricalContainerView: IHistoricalView {
    func instanceHistoricalViewFromNib() -> UIView {
        return HistoricalContainerView.instanceFromNib(nibName: Constant.view.historicalView.historicalContainerView)
    }
    
    func didSelectHistoricalRow(mainStack: AwesomeStackView) {
        
    }
    
    
}

