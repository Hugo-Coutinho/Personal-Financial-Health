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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.mainStackView.axis = .vertical
        self.mainStackView.alignment = .fill
        self.mainStackView.distribution = .fill
        self.mainStackView.spacing = 0
        self.mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let header = ExpenseHeaderView.instanceFromNib(nibName: "ExpenseView")
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didSelectView))
//        header.addGestureRecognizer(tapGesture)
//        header.tag = n + 1
//        n = n+1
        self.mainStackView.addArrangedSubview(header)
        
//                let green = UIView()
//                green.backgroundColor = UIColor.green
//                green.translatesAutoresizingMaskIntoConstraints = false
//                green.heightAnchor.constraint(equalToConstant: 40).isActive = true
//                self.mainStackView.addArrangedSubview(green)
//        
//                let blue = UIView()
//                blue.backgroundColor = UIColor.blue
//                blue.translatesAutoresizingMaskIntoConstraints = false
//                blue.heightAnchor.constraint(equalToConstant: 40).isActive = true
//                self.mainStackView.addArrangedSubview(blue)
//        
//                let yellow = UIView()
//                yellow.backgroundColor = UIColor.yellow
//                yellow.translatesAutoresizingMaskIntoConstraints = false
//                yellow.heightAnchor.constraint(equalToConstant: 40).isActive = true
//                self.mainStackView.addArrangedSubview(yellow)
    }
    
    @objc private func didSelectView(_ sender: AnyObject) {
        print(sender.view.tag)
        
        let body = ExpenseBodyView.instanceFromNib(nibName: Constant.View.expenseBody)
        body.tag = 1
        if self.isOpen {
            self.mainStackView.removeArrangedSubview(self.mainStackView.arrangedSubviews.filter({ $0.tag == 1 }).first!)
            self.isOpen = false
        } else {
//         self.mainStackView.addArrangedSubview(body)
            if self.mainStackView.arrangedSubviews.count >= 4 {
                self.mainStackView.insertArrangedSubview(body, at: 4)
                self.isOpen = true
            }
        }
    }
}
