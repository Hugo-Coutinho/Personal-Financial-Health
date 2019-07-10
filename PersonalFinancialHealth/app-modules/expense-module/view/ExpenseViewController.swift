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
    
    
    @IBAction func goHome(_ sender: Any) {
        Coordinator.setVisibleScreen(vc: HomeRouter.createModule(), hidesBackButton: true)
    }
}

// MARK: - LIFE CYCLE VIEW CONTROLLER -
extension ExpenseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.configureNavigationItem(hidesBackButton: false)
    }
}
