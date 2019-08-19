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
    @IBOutlet weak var mainStackView: StackViewController!
    
    // MARK: - CONSTANTS -
    
    // MARK: - VARIABLES -
    private lazy var isOpen: Bool = false
    private lazy var n = 0
}

// MARK: - LIFE CYCLE VIEW CONTROLLER -
extension ExpenseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationItem(hidesBackButton: false)
        self.mainStackView.dataSource = self
        self.mainStackView.delegate = self
        self.mainStackView.initialize()
//        let blur = ExpenseFormView.instanceFromNib(nibName: "PopupMenu")
//        self.view.insertSubview(blur, at: self.view.subviews.count + 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.mainStackView.axis = .vertical
        self.mainStackView.alignment = .fill
        self.mainStackView.distribution = .fill
        self.mainStackView.spacing = 0
        self.mainStackView.translatesAutoresizingMaskIntoConstraints = false
        self.mainStackView.layoutIfNeeded()
    }
    
    @objc private func didSelectView(_ sender: AnyObject) {
        let expensesList = ExpenseContainerView.instanceFromNib(nibName: "ExpenseContainerView")
        self.mainStackView.addArrangedSubview(expensesList)
    }
}

// MARK: - STACKVIEW DATASOURCE -
extension ExpenseViewController: StackViewDataSource {
    func stackView(_ stackView: UIStackView, viewForRowAt index: Int) -> UIView {
        switch index {
        case 0:
            return ExpenseFormView.instanceFromNib(nibName: "ExpenseFormView")
        case 1:
            return ExpenseFormView.instanceFromNib(nibName: "ExpenseFormView", index: 1)
        case 2:
            return ExpenseFormView.instanceFromNib(nibName: "ExpenseFormView", index: 2)
        case 3:
            return ExpenseFormView.instanceFromNib(nibName: "ExpenseFormView", index: 3)
        default:
            return UIView()
        }
    }
    
    func stackView(_ stackView: UIStackView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
}

// MARK: - STACKVIEW DATASOURCE -
extension ExpenseViewController: StackViewDelegate {
    func stackView(_ stackView: UIStackView, didSelectRowAt index: Int, view: UIView) {
        if index == 1 {
            if self.mainStackView.viewWithTag(2) != nil {
                (self.mainStackView.arrangedSubviews[1] as? ConstantCollapseView)?.closeConstantExpense()
            self.mainStackView.removeChild(at: 2)
            } else {
                (self.mainStackView.arrangedSubviews[1] as? ConstantCollapseView)?.openConstantExpense()
                self.mainStackView.addChildView(childView: ExpenseFormView.instanceFromNib(nibName: "ExpenseFormView", index: 2), at: 2)
            }
        }
    }
}
