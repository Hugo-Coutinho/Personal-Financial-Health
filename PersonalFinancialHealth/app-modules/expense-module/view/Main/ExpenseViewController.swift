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
    func didSelectRow(mainStack: StackViewController)
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
    @IBOutlet var mainStackView: StackViewController!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - CONSTANTS -
    
    // MARK: - VARIABLES -
    private lazy var presenter: ExpensePresenterInput = ExpensePresenter.make(view: self)
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
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter.checkFinancialBudget()
        self.configureSubViews()
        self.configureMainStackView()
    }
}

// MARK: - CONFIGURATION UI COMPONENTS -
extension ExpenseViewController {
    func configureMainStackView() {
        self.mainStackView.dataSource = self
        self.mainStackView.delegate = self
        self.mainStackView.initialize()
    }
    
    private func configureSubViews() {
        self.subViews.append(ExpenseFormView())
        self.subViews.append(ConstantCollapseView())
        self.subViews.append(ConfirmView())
        self.addingListContainerView()
        self.didLoadEmptyViewManagment()
    }
    
    func addingListContainerView() {
        guard !self.subViews.contains(where: { $0 is ExpenseListContainerView }),
            !self.presenter.expenseIsEmpty() else { return }
        self.subViews.append(ExpenseListContainerView())
    }
    
    func didLoadEmptyViewManagment() {
        guard !self.subViews.contains(where: { $0 is ExpenseListContainerView }) else { self.subViews.removeAll(where: { $0 is EmptyPageView }); return }
        self.subViews.append(EmptyPageView())
    }
    
    private func addEmptySection() {
        self.subViews.append(EmptyPageView())
    }
    
    private func removeEmptySection() {
        self.subViews.removeAll(where: { $0 is EmptyPageView })
    }
}

// MARK: - STACKVIEW DATASOURCE -
extension ExpenseViewController: StackViewDataSource {
    func stackView(_ stackView: UIStackView, customSpacingForRow index: Int) -> Int {
        guard self.isCurrentViewEqualToConfirmView(index: index) else { return 8 }
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

// MARK: - STACKVIEW DELEGATE -
extension ExpenseViewController: StackViewDelegate {
    func stackView(_ stackView: UIStackView, didSelectRowAt index: Int, view: UIView) {
        guard self.currentViewExist(index: index) else { return }
        self.subViews[index].didSelectRow(mainStack: self.mainStackView)
    }
}

// MARK: - STACKVIEW DATASOURCE LOGIC -
extension ExpenseViewController {
    private func isCurrentViewEqualToConfirmView(index: Int) -> Bool {
        guard let confirmView = self.mainStackView.arrangedSubviews.first(where: { $0 is ConfirmView }),
            let confirmViewIndex = self.mainStackView.arrangedSubviews.firstIndex(of: confirmView),
            index == confirmViewIndex else { return false }
        return true
    }
    
    private func currentViewExist(index: Int) -> Bool {
        return self.subViews.count >= index
    }
}

// MARK: - PRESENTER OUTPUT -
extension ExpenseViewController: ExpensePresenterToView {
    
}
