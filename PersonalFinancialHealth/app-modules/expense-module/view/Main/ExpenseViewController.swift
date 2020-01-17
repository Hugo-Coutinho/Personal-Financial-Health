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
    
    // MARK: - ENUMS -
    enum SubViewsEnum: Int {
        case form = 0
        case collapse = 1
        case pickerView = 2
        case confirmButton = 3
    }
    
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
        self.configureMainStackView()
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.view.layoutIfNeeded()
    }
}

// MARK: - CONFIGURATION UI COMPONENTS -
extension ExpenseViewController {
    func configureMainStackView() {
        self.mainStackView.dataSource = self
        self.mainStackView.delegate = self
        self.mainStackView.initialize()
        self.mainStackView.axis = .vertical
        self.mainStackView.alignment = .fill
        self.mainStackView.distribution = .fill
        self.mainStackView.spacing = 8
        self.mainStackView.translatesAutoresizingMaskIntoConstraints = false
        self.mainStackView.layoutIfNeeded()
    }
}

// MARK: - STACKVIEW DATASOURCE -
extension ExpenseViewController: StackViewDataSource {
    func stackView(_ stackView: UIStackView, viewForRowAt index: Int) -> UIView {
        switch index {
        case SubViewsEnum.form.rawValue:
            return ExpenseFormView.instanceFromNib(nibName: "ExpenseFormView")
        case SubViewsEnum.collapse.rawValue:
            return ConstantCollapseView.instanceFromNib(nibName: "ConstantCollapseView")
        case SubViewsEnum.pickerView.rawValue:
            return ConstantPickerView.instanceFromNib(nibName: "ConstantPickerView")
        case SubViewsEnum.confirmButton.rawValue:
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
        let collapseView = 1
        if index == collapseView {
            self.didSelectCollapseView()
        }
    }
}

// MARK: - DID SELECT COLLAPSE -
extension ExpenseViewController {
    private func didSelectCollapseView() {
        let subViewPositionTwo =  self.mainStackView.arrangedSubviews[SubViewsEnum.pickerView.rawValue]
        guard !(subViewPositionTwo is ConstantPickerView) else { return self.hiddenPickerView(collapseView: self.getCollapseViewFromMainStackView()) }
        self.addSubviewPickerView(collapseView: self.getCollapseViewFromMainStackView())
    }
    
    private func getCollapseViewFromMainStackView() -> ConstantCollapseView? {
        return self.mainStackView.arrangedSubviews[SubViewsEnum.collapse.rawValue] as? ConstantCollapseView
    }
    
    private func addSubviewPickerView(collapseView: ConstantCollapseView? ) {
        collapseView?.openConstantExpense()
        self.mainStackView.addChildView(childView: ConstantPickerView.instanceFromNib(nibName: "ConstantPickerView"), at: SubViewsEnum.pickerView.rawValue)
    }
    private func hiddenPickerView(collapseView: ConstantCollapseView? ) {
        collapseView?.closeConstantExpense();
        self.mainStackView.removeChild(at: SubViewsEnum.pickerView.rawValue)
        return
    }
}
