//
//  HistoricalBodyView.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 27/03/20.
//  Copyright © 2020 Hugo. All rights reserved.
//

import UIKit
import AwesomeStackView

class HistoricalBodyView: UIView {
    
    // MARK: - OUTLETS -
    
    
    // MARK: - LIFE CYCLE -
    override func awakeFromNib() {
        
    }
}


// MARK: - IMPLEMENTS PROTOCOL HISTORICAL VIEWS -
extension HistoricalBodyView: IHistoricalView {
    func instanceHistoricalViewFromNib() -> UIView {
        return HistoricalContainerView.instanceFromNib(nibName: Constant.view.historicalView.historicalBodyView)
    }
    
    func didSelectHistoricalRow(mainStack: AwesomeStackView) {
        
    }
}

