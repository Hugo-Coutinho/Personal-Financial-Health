//
//  EmptyPage.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 28/03/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import UIKit

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
    
    func didSelectHistoricalRow(mainStack: StackViewController) {
        
    }
}

// MARK: - EXPENSE -
extension EmptyPageView: IExpenseSubView {
    func didSelectRow(mainStack: StackViewController) {
        
    }
    
    func instanceExpenseSubViewFromNib() -> UIView {
        let emptyView = EmptyPageView().instanceHistoricalViewFromNib() as! EmptyPageView
        emptyView.MessageLabel.text = NSLocalizedString("expenseEmptyMessageLabel", comment: "")
        emptyView.heightAnchor.constraint(equalToConstant: CGFloat(180.0))
        return emptyView
    }
}


