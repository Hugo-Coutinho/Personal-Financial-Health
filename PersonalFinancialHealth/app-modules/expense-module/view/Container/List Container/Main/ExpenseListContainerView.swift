//
//  ExpenseListContainerView.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 23/08/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit

class ExpenseListContainerView: UIView {
    
    // MARK: - OUTLET -
    @IBOutlet weak var listContainerStackView: UIStackView!
    
    // MARK: - OVERRIDE -
    override func awakeFromNib() {
        self.appendViews()
        self.backgroundColor = .red
    }
    
    override func layoutSubviews() {
        self.listContainerStackView.axis = .vertical
        self.listContainerStackView.alignment = .fill
        self.listContainerStackView.distribution = .fill
        self.listContainerStackView.spacing = 0
        self.listContainerStackView.translatesAutoresizingMaskIntoConstraints = false
        self.listContainerStackView.layoutIfNeeded()
        self.layoutIfNeeded()
    }

    public func appendViews() {
        self.listContainerStackView.arrangedSubviews.forEach({ $0.removeFromSuperview() })
        let item = ExpenseListItemView.instanceFromNib(nibName: "ExpenseListView", index: 1)
        (item as? ExpenseListItemView)?.configureSubItems()
        self.listContainerStackView.addArrangedSubview(item)
        
//        self.heightAnchor.constraint(equalToConstant: self.listContainerStackView.frame.height).isActive = true
//        self.layoutIfNeeded()
//        self.listContainerStackView.layoutIfNeeded()
    }
}
