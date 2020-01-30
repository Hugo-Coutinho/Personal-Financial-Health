//
//  EpenseViewController.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 09/07/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit

protocol IExpenseSubView {
    func instanceExpenseSubViewFromNib() -> UIView
}


class ExpenseViewController: UIViewController {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var mainStackView: StackViewController!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - ENUMS -
    enum subViewsEnum: Int {
        case form = 0
        case collapse = 1
        case pickerView = 2
        case confirmButton = 3
    
        func getIndex() -> Int {
            return self.rawValue
        }
    }
    
    // MARK: - CONSTANTS -
    
    // MARK: - VARIABLES -
    private lazy var isOpen: Bool = false
    private lazy var n = 0
    private lazy var formView = ExpenseFormView()
    private lazy var subViews = [IExpenseSubView]()
}

// MARK: - LIFE CYCLE VIEW CONTROLLER -
extension ExpenseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationItem(hidesBackButton: false)
        self.addingExpenseSubViews()
        self.configureMainStackView()
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.view.layoutIfNeeded()
    }
    
    private func addingExpenseSubViews() {
        self.subViews.append(ExpenseFormView())
        self.subViews.append(ConstantCollapseView())
        self.subViews.append(ConstantPickerView())
        self.subViews.append(ConfirmView())
        self.subViews.append(ExpenseListContainerView())
    }
}

// MARK: - CONFIGURATION UI COMPONENTS -
extension ExpenseViewController {
    func configureMainStackView() {
        self.mainStackView.dataSource = self
        self.mainStackView.delegate = self
        self.mainStackView.initialize()
    }
}

// MARK: - STACKVIEW DATASOURCE -
extension ExpenseViewController: StackViewDataSource {
    func stackView(_ stackView: UIStackView, customSpacingForRow index: Int) -> Int {
        guard index == subViewsEnum.confirmButton.getIndex() else { return 8 }
        return 32
    }
    
    func stackView(_ stackView: UIStackView, viewForRowAt index: Int) -> UIView {
        guard self.currentViewExist(index: index) else { return UIView() }
        return self.subViews[index].instanceExpenseSubViewFromNib()
    }
    
    func stackView(_ stackView: UIStackView, numberOfRowsInSection section: Int) -> Int {
        return self.subViews.count
    }
}

// MARK: - STACKVIEW DATASOURCE -
extension ExpenseViewController: StackViewDelegate {
    func stackView(_ stackView: UIStackView, didSelectRowAt index: Int, view: UIView) {
        if  self.didSelectRowAtCollapseView(index: index) {
            self.didSelectCollapseView()
        }
    }
}

// MARK: - STACKVIEW VIEW FOR ROW LOGIC -
extension ExpenseViewController {
    private func currentViewExist(index: Int) -> Bool {
        return self.subViews.count >= index
    }
}

// MARK: - DID SELECT COLLAPSE -
extension ExpenseViewController {
    private func didSelectRowAtCollapseView(index: Int) -> Bool {
        return index == subViewsEnum.collapse.getIndex()
    }
    private func didSelectCollapseView() {
        guard self.subViewPickerViewIsHidden() else { return self.hiddenPickerView(collapseView: self.getCollapseViewFromMainStackView()) }
        self.addSubviewPickerView(collapseView: self.getCollapseViewFromMainStackView())
    }
    
    private func subViewPickerViewIsHidden() -> Bool {
        let subViewPositionTwo =  self.mainStackView.arrangedSubviews[subViewsEnum.pickerView.getIndex()]
        return !(subViewPositionTwo is ConstantPickerView)
    }
    
    private func getCollapseViewFromMainStackView() -> ConstantCollapseView? {
        return self.mainStackView.arrangedSubviews[subViewsEnum.collapse.getIndex()] as? ConstantCollapseView
    }
    
    private func addSubviewPickerView(collapseView: ConstantCollapseView?) {
        collapseView?.openConstantExpense()
        self.mainStackView.addChildView(childView: ConstantPickerView.instanceFromNib(nibName: Constant.view.expenseView.expensePickerView), at: subViewsEnum.pickerView.getIndex())
    }
    
    private func hiddenPickerView(collapseView: ConstantCollapseView?) {
        collapseView?.closeConstantExpense();
        self.mainStackView.removeChild(at: subViewsEnum.pickerView.getIndex())
        return
    }
}
