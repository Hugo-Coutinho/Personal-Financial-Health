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
    @IBOutlet weak var scrollView: UIScrollView!
    
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
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.mainStackView.axis = .vertical
        self.mainStackView.alignment = .fill
        self.mainStackView.distribution = .fill
        self.mainStackView.spacing = 8
        self.mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        //let currentHeight = self.view.bounds.height
        //let newHeight = (currentHeight + self.mainStackView.frame.height)
        
        
        self.mainStackView.layoutIfNeeded()
        self.view.layoutIfNeeded()
    }
}

// MARK: - STACKVIEW DATASOURCE -
extension ExpenseViewController: StackViewDataSource {
    func stackView(_ stackView: UIStackView, viewForRowAt index: Int) -> UIView {
        switch index {
        case 0:
            return ExpenseFormView.instanceFromNib(nibName: "ExpenseFormView")
        case 1:
            return ConstantCollapseView.instanceFromNib(nibName: "ConstantCollapseView")
        case 2:
            return ConstantPickerView.instanceFromNib(nibName: "ConstantPickerView")
        case 3:
            return ConfirmView.instanceFromNib(nibName: "ConfirmView")
        default:
            return ExpenseListContainerView.instanceFromNib(nibName: "ExpenseListContainerView")
        }
    }
    
    func stackView(_ stackView: UIStackView, numberOfRowsInSection section: Int) -> Int {
        return 5
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
                self.mainStackView.addChildView(childView: ConstantPickerView.instanceFromNib(nibName: "ConstantPickerView"), at: 2)
            }
        } else if let containerView = (self.mainStackView.arrangedSubviews[index] as? ExpenseListContainerView) {
            print(containerView.frame.height)
        }
    }
}
