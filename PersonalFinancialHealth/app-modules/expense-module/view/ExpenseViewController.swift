//
//  EpenseViewController.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 09/07/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit

class ExpenseViewController: UIViewController {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var mainStackView: UIStackView!
    
    // MARK: - CONSTANTS -
    
    // MARK: - VARIABLES -
    private var isOpen: Bool = false
    private var n = 0
}

// MARK: - LIFE CYCLE VIEW CONTROLLER -
extension ExpenseViewController {
    override func viewDidLoad() {
        self.configureNavigationItem(hidesBackButton: false)
        super.viewDidLoad()
        let expenseFormView = ExpenseFormView.instanceFromNib(nibName: "ExpenseFormView")
        self.mainStackView.addArrangedSubview(expenseFormView)
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didSelectView))
                expenseFormView.addGestureRecognizer(tapGesture)
        self.mainStackView.addArrangedSubview(expenseFormView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.mainStackView.axis = .vertical
        self.mainStackView.alignment = .fill
        self.mainStackView.distribution = .fill
        self.mainStackView.spacing = 10
        self.mainStackView.translatesAutoresizingMaskIntoConstraints = false
        self.mainStackView.layoutIfNeeded()
    }
    
    @objc private func didSelectView(_ sender: AnyObject) {
        let expensesList = ExpenseContainerView.instanceFromNib(nibName: "ExpenseContainerView")
        self.mainStackView.addArrangedSubview(expensesList)
    }
}
