//
//  HistoricalViewController.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 27/03/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import UIKit

// MARK: - EXPENSE SUBVIEW INTERFACE -
protocol IHistoricalView {
    func instanceExpenseSubViewFromNib() -> UIView
    func didSelectRow(mainStack: StackViewController)
}


class HistoricalViewController: UIViewController {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var mainStackView: StackViewController!
    
    // MARK: - VARIABLES -
    private lazy var subViews = [IHistoricalView]()
    
    
}
// MARK: - LIFE CYCLE VIEW CONTROLLER -
extension HistoricalViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureSubViews()
        self.configureMainStackView()
    }
}

// MARK: - AUX METHODS -
extension HistoricalViewController {
    private func configureSubViews() {
        self.subViews.append(HistoricalHeaderView())
    }
    
    func configureMainStackView() {
        self.mainStackView.dataSource = self
        self.mainStackView.delegate = self
        self.mainStackView.initialize()
    }
}

// MARK: - STACKVIEW DATASOURCE -
extension HistoricalViewController: StackViewDataSource {
    func stackView(_ stackView: UIStackView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func stackView(_ stackView: UIStackView, customSpacingForRow index: Int) -> Int {
        return self.subViews.count
    }
    
    func stackView(_ stackView: UIStackView, viewForRowAt index: Int) -> UIView {
        return self.subViews[index].instanceExpenseSubViewFromNib()
    }
}

// MARK: - STACKVIEW DELEGATE -
extension HistoricalViewController: StackViewDelegate {
}

