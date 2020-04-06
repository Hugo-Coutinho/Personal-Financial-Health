//
//  EmptyPage.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 28/03/20.
//  Copyright © 2020 Hugo. All rights reserved.
//

import UIKit
import AwesomeStackView

class EmptyPageView: UIView {
    
    // MARK: - OUTLET -
    @IBOutlet weak var MessageLabel: UILabel!
    
    // MARK: - CONSTANTS -
    let nibName = "EmptyPageView"
    
    override func awakeFromNib() {
        self.MessageLabel.text = ""
    }
}

// MARK: - HISTORICAL -
extension EmptyPageView: IHistoricalView {
    func instanceHistoricalViewFromNib() -> UIView {
        return HistoricalContainerView.instanceFromNib(nibName: "EmptyPageView")
    }
    
    func didSelectHistoricalRow(mainStack: AwesomeStackView) {
        
    }
}

// MARK: - EXPENSE -
extension EmptyPageView: IExpenseSubView {
    func didSelectRow(mainStack: AwesomeStackView) {
        
    }
    
    func instanceExpenseSubViewFromNib() -> UIView {
        let emptyView = EmptyPageView().instanceHistoricalViewFromNib() as! EmptyPageView
        emptyView.MessageLabel.text = NSLocalizedString("expenseEmptyMessageLabel", comment: "")
        return emptyView
    }
}


