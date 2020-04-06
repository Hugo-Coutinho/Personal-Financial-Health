//
//  ExpenseListContainerView.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 23/08/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit
import AwesomeStackView

protocol IExpenseContainerSubView {
    func instanceExpenseContainerSubViewFromNib() -> UIView
}


class ExpenseListContainerView: UIView {
    
    // MARK: - OUTLET -
    
    @IBOutlet weak var listcontainerStackView: AwesomeStackView!
    
    // MARK: - PROPERTIES -
    lazy var arrangedSubviews: [IExpenseContainerSubView] = [
//    ExpenseListSectionView()
    ]
    private lazy var worker: CoreDataWorkerInput = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorExpense)
    private lazy var blFinancial: BLFinancial = BLFinancial(worker: self.worker)
    
    // MARK: - OVERRIDE -
    override func awakeFromNib() {
        self.setupActiveExpenses()
        self.listcontainerStackView.dataSource = self
        self.listcontainerStackView.initialize()
    }
}

// MARK: - STACKVIEW DATASOURCE -
extension ExpenseListContainerView: AwesomeStackViewDataSource {
    func stackView(_ stackView: UIStackView, customSpacingForRow index: Int) -> Int {
        return 64
    }
    
    func stackView(_ stackView: UIStackView, numberOfRowsInSection section: Int) -> Int {
        return self.arrangedSubviews.count
    }
    
    func stackView(_ stackView: UIStackView, viewForRowAt index: Int) -> UIView {
        return self.getViewForRow(index: index)
    }
}

// MARK: - HELPER METHODS -
extension ExpenseListContainerView {
    func setupActiveExpenses() {
        self.blFinancial.getExpenses(successExpenses: { (expenses) in
            guard expenses.count > 0 else { return }
            self.arrangedSubviews.append(ExpenseListSectionView())
            self.arrangedSubviews.append(ExpenseListSectionView())
        }) { (error) in }
    }
}

// MARK: - STACKVIEW AUX METHODS -
extension ExpenseListContainerView {
    private func getViewForRow(index: Int) -> UIView {
        var view: ExpenseListSectionView = ExpenseListSectionView()
        self.blFinancial.getExpenses(successExpenses: { (expenses) in
            guard self.viewForRowIsValid(index: index) else { return }
            view = self.getExpenseSection(item: expenses, index: index)
        }) { (error) in }
        return view
    }
    
    private func getExpenseSection(item: [ExpenseItemModel], index: Int) -> ExpenseListSectionView {
        let currentView = self.arrangedSubviews[index].instanceExpenseContainerSubViewFromNib()
        guard let sectionView = (currentView as? ExpenseListSectionView) else { return ExpenseListSectionView() }
        return sectionView.setupSectionView(sectionView: sectionView, itemModel: item, index: index)
    }
    
    private func viewForRowIsValid(index: Int) -> Bool {
        return self.subviews.count >= index
    }
}

// MARK: - IMPLEMENTS PROTOCOL EXPENSE SUBVIEWS -
extension ExpenseListContainerView: IExpenseSubView {
    func didSelectRow(mainStack: AwesomeStackView) {
        
    }
    
    func instanceExpenseSubViewFromNib() -> UIView {
        return ExpenseListContainerView.instanceFromNib(nibName: Constant.view.expenseView.expenseListcontainer)
    }
}

