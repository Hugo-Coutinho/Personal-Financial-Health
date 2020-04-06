//
//  ExpenseListSectionView.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 07/09/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import UIKit
import AwesomeStackView

class ExpenseListSectionView: UIView {
    
    // MARK: - OUTLET -
    @IBOutlet weak var sectionView: UIView!
    @IBOutlet weak var totalExpendedLabel: UILabel!
    @IBOutlet weak var expenseTypeLabel: UILabel!
    @IBOutlet weak var totalExpendedView: UIView!
    @IBOutlet weak var itemMainStackView: AwesomeStackView!
    
    // MARK: - VARIABLE -
    private lazy var arrangedItemModels: [ExpenseItemModel] = []
    private lazy var worker: CoreDataWorkerInput = CoreDataWorker.make(sortDescriptionKey: Constant.persistence.sortDescriptorExpense)
    private lazy var blFinancial: BLFinancial = BLFinancial(worker: self.worker)
    
    // MARK: - OVERRIDE -
    override func awakeFromNib() {
        self.itemMainStackView.dataSource = self
        self.itemMainStackView.initialize()
        self.addGestureRecognizer()
        self.itemMainStackView.isHidden = true
    }
    
    // MARK: - MAKE VIEW -
    public func setupSectionView(sectionView: ExpenseListSectionView, itemModel: [ExpenseItemModel], index: Int) -> ExpenseListSectionView {
        let totalExpendedFormatString = NSLocalizedString("totalExpendedLabel", comment: "")
        let totalExpended = self.getTotalExpended(itemModel: itemModel, index: index)
        sectionView.totalExpendedLabel.text = String.localizedStringWithFormat(totalExpendedFormatString, totalExpended)
        sectionView.expenseTypeLabel.text = NSLocalizedString( self.getExpenseTypeValue(sectionIndex: index), comment: "")
        self.financialStateUpdateTotalViewColor(itemModel: itemModel)
        self.updateArrangedItems(itemModel: itemModel, index: index)
        self.configureUserInteraction(totalExpended: totalExpended)
        
        return sectionView
    }
}

// MARK: - STACKVIEW DATASOURCE -
extension ExpenseListSectionView: AwesomeStackViewDataSource {
    func stackView(_ stackView: UIStackView, customSpacingForRow index: Int) -> Int {
        return 0
    }
    
    func stackView(_ stackView: UIStackView, numberOfRowsInSection section: Int) -> Int {
        return self.arrangedItemModels.count
    }
    
    func stackView(_ stackView: UIStackView, viewForRowAt index: Int) -> UIView {
        return self.getViewForRow(index: index)
    }
}

// MARK: - STACKVIEW AUX FUNCTIONS -
extension ExpenseListSectionView {
    private func getViewForRow(index: Int) -> UIView {
        guard self.currentViewExist(index: index) else { return self.instantiateListItem() }
        let itemView = self.instantiateListItem()
        let itemViewPrepared = itemView.setupItemView(itemModel: self.arrangedItemModels[index])
        return itemViewPrepared
    }
}

// MARK: - AUX METHODS -
extension ExpenseListSectionView {
    func financialStateUpdateTotalViewColor(itemModel: [ExpenseItemModel]) {
        self.totalExpendedView.backgroundColor = self.blFinancial.financialStateUpdateTotalViewColor(itemModel: itemModel)
    }
    
    func configureUserInteraction(totalExpended: Double) {
        guard totalExpended > 0 else { self.isUserInteractionEnabled = false; return }
        self.isUserInteractionEnabled = true
    }
    
    func getTotalExpended(itemModel: [ExpenseItemModel], index: Int) -> Double {
        return index == 0 ? self.getTotalConstantExpended(itemModel: itemModel) : self.getTotalDailyExpended(itemModel: itemModel)
    }
    
    func getTotalConstantExpended(itemModel: [ExpenseItemModel]) -> Double {
        return itemModel.filter({ $0.expenseType == 0 }).map({ $0.subItems.map({ $0.expended }).reduce(0, +) }).reduce(0, +)
    }
    
    func getTotalDailyExpended(itemModel: [ExpenseItemModel]) -> Double {
        return itemModel.filter({ $0.expenseType == 1 }).map({ $0.subItems.map({ $0.expended }).reduce(0, +) }).reduce(0, +)
    }
    
    func getExpenseType(itemModel: [ExpenseItemModel], index: Int) -> Int {
        guard index == 0 && itemModel.filter({ $0.expenseType == 0 }).count > 0 else { return 1 }
        return 0
    }
    
    func getExpenseTypeValue(sectionIndex: Int) -> String {
        return sectionIndex == 0 ? "expenseConstantTypeLabel" : "expenseDailyTypeLabel"
    }
    
    private func updateArrangedItems(itemModel: [ExpenseItemModel], index: Int) {
        let arrangedItemNames = self.arrangedItemModels.map({ $0.name })
        let newItemsToInsert = itemModel.filter({ arrangedItemNames.contains($0.name) == false })
        guard newItemsToInsert.count > 0 else { return }
        newItemsToInsert.filter({ $0.expenseType == index }).forEach { (currentItem) in
            self.arrangedItemModels.append(currentItem)
        }
    }
    
    private func instantiateListItem() -> ExpenseListItemView {
        return ExpenseListItemView.instanceFromNib(nibName: Constant.view.expenseView.expenseListItem) as! ExpenseListItemView
    }
}


// MARK: - MICRO FUNCTIONS ANIMATION -
extension ExpenseListSectionView {
    private func currentViewExist(index: Int) -> Bool {
        return self.arrangedItemModels.count >= index
    }
    
    private func addGestureRecognizer() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didSelectSection))
        self.sectionView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didSelectSection() {
        guard self.itemViewIsHidden() else { self.removeItemView(); return }
        self.showItemView()
    }
    
    private func itemViewIsHidden() -> Bool {
        return self.itemMainStackView.arrangedSubviews.isEmpty
    }
    
    private func showItemView() {
        self.itemMainStackView.isHidden = false
        self.itemMainStackView.reloadStackView()
    }
    
    private func removeItemView() {
        self.itemMainStackView.isHidden = true
        self.itemMainStackView.removeAll()
    }
}

// MARK: - IMPLEMENTS INTERFACE -
extension ExpenseListSectionView: IExpenseContainerSubView {
    func instanceExpenseContainerSubViewFromNib() -> UIView {
        return ExpenseListSectionView.instanceFromNib(nibName: Constant.view.expenseView.expenseSection)
    }
}

