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
    let expenseCell = ExpenseView.instanceFromNib(nibName: Constant.View.expenseView)
    
    @IBAction func goHome(_ sender: Any) {
        Coordinator.setVisibleScreen(vc: HomeRouter.createModule())
    }
}

// MARK: - LIFE CYCLE VIEW CONTROLLER -
extension ExpenseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.mainStackView.axis = .vertical
        self.mainStackView.alignment = .fill
        self.mainStackView.distribution = .fill
        self.mainStackView.spacing = 8
        self.mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let green = UIView()
        green.backgroundColor = UIColor.green
        green.translatesAutoresizingMaskIntoConstraints = false
        green.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.mainStackView.addArrangedSubview(green)
        
        let blue = UIView()
        blue.backgroundColor = UIColor.blue
        blue.translatesAutoresizingMaskIntoConstraints = false
        blue.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.mainStackView.addArrangedSubview(blue)
        
        let yellow = UIView()
        yellow.backgroundColor = UIColor.yellow
        yellow.translatesAutoresizingMaskIntoConstraints = false
        yellow.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.mainStackView.addArrangedSubview(yellow)
    }
}
