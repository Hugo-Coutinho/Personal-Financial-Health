//
//  ExpenseListSectionView.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 07/09/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit

class ExpenseListSectionView: UIView {
    
    // MARK: - OUTLET -
    @IBOutlet weak var sectionView: UIView!
    @IBOutlet weak var totalExpendedLabel: UILabel!
    @IBOutlet weak var expenseTypeLabel: UILabel!
    @IBOutlet weak var itemMainStackView: StackViewController!
    
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
        let defaultTotal = "R$ 00,00"
        var totalExpended: String = ""
        totalExpended = self.getTotalExpended(itemModel: itemModel, index: index)
        sectionView.totalExpendedLabel.text = defaultTotal.replace("00,00", withString: totalExpended)
        sectionView.expenseTypeLabel.text = self.getExpenseTypeValue(sectionIndex: index)
        self.updateArrangedItems(itemModel: itemModel, index: index)
        self.configureUserInteraction(totalExpended: totalExpended)
        return sectionView
    }
}

// MARK: - STACKVIEW DATASOURCE -
extension ExpenseListSectionView: StackViewDataSource {
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
    func configureUserInteraction(totalExpended: String) {
        guard let expended = Double(totalExpended),
            expended > 0 else { self.isUserInteractionEnabled = false; return }
        self.isUserInteractionEnabled = true
    }
    
    func getTotalExpended(itemModel: [ExpenseItemModel], index: Int) -> String {
        return index == 0 ? self.getTotalConstantExpended(itemModel: itemModel) : self.getTotalDailyExpended(itemModel: itemModel)
    }
    
    func getTotalConstantExpended(itemModel: [ExpenseItemModel]) -> String {
        return String(itemModel.filter({ $0.expenseType == 0 }).map({ $0.subItems.map({ $0.expended }).reduce(0, +) }).reduce(0, +))
    }
    
    func getTotalDailyExpended(itemModel: [ExpenseItemModel]) -> String {
        return String(itemModel.filter({ $0.expenseType == 1 }).map({ $0.subItems.map({ $0.expended }).reduce(0, +) }).reduce(0, +))
    }
    
    func getExpenseType(itemModel: [ExpenseItemModel], index: Int) -> Int {
        guard index == 0 && itemModel.filter({ $0.expenseType == 0 }).count > 0 else { return 1 }
        return 0
    }
    
    func getExpenseTypeValue(sectionIndex: Int) -> String {
        return sectionIndex == 0 ? "Constant Expense" : "Daily Expense"
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

