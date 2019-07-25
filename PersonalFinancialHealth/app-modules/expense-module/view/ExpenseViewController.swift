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
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var expenseView: UIView!
    
    // MARK: - CONSTANTS -
    
    // MARK: - VARIABLES -
    private var isOpen: Bool = false
    private var n = 0
    
    @IBAction func goHome(_ sender: Any) {
        Coordinator.setVisibleScreen(vc: HomeRouter.createModule())
    }
}

// MARK: - LIFE CYCLE VIEW CONTROLLER -
extension ExpenseViewController {
    override func viewDidLoad() {
        self.configureNavigationItem(hidesBackButton: false)
        super.viewDidLoad()
        let expenseView = ExpenseHeaderView.instanceFromNib(nibName: "ExpenseView")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didSelectView))
        expenseView.addGestureRecognizer(tapGesture)
        (expenseView as! ExpenseView).sectionView.isHidden = false
        self.mainStackView.addArrangedSubview(expenseView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.mainStackView.axis = .vertical
        self.mainStackView.alignment = .fill
        self.mainStackView.distribution = .fill
        self.mainStackView.spacing = 0
        self.mainStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func didSelectView(_ sender: AnyObject) {
        
        let expenseView = ExpenseHeaderView.instanceFromNib(nibName: "ExpenseView")
        (expenseView as! ExpenseView).itemView.isHidden = false
        self.mainStackView.spacing = 30.0
        self.mainStackView.addArrangedSubview(expenseView)
    }
}
