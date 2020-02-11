//
//  EpenseViewController.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 09/07/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit

// MARK: - EXPENSE SUBVIEW INTERFACE -
protocol IExpenseSubView {
    func instanceExpenseSubViewFromNib() -> UIView
    func didSelectRow()
}

// MARK: - EXPENSE VIEW DATA -
struct ExpenseParentViewData {
    var stack: StackViewController
}

// MARK: - ENUMS -
enum expenseSubViewEnum: Int {
    case form = 0
    case collapse = 1
    case pickerView = 2
    case confirmButton = 3
    
    func getIndex() -> Int {
        return self.rawValue
    }
}

class ExpenseViewController: UIViewController {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var mainStackView: StackViewController!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - CONSTANTS -
    
    // MARK: - VARIABLES -
    private lazy var presenter: ExpenseViewToPresenter = ExpensePresenter.make(view: self)
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
        let collapseView = ConstantCollapseView()
        collapseView.parentData = ExpenseParentViewData(stack: self.mainStackView)
        self.subViews.append(ExpenseFormView())
        self.subViews.append(collapseView)
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
        guard index == expenseSubViewEnum.confirmButton.getIndex() else { return 8 }
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
        guard self.currentViewExist(index: index) else { return }
        self.subViews[index].didSelectRow()
    }
}

// MARK: - STACKVIEW VIEW FOR ROW LOGIC -
extension ExpenseViewController {
    private func currentViewExist(index: Int) -> Bool {
        return self.subViews.count >= index
    }
}

// MARK: - PRESENTER OUTPUT -
extension ExpenseViewController: ExpensePresenterToView {

}
