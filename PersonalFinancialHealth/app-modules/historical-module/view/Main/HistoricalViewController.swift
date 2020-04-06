//
//  HistoricalViewController.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 27/03/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import UIKit
import AwesomeStackView

// MARK: - EXPENSE SUBVIEW INTERFACE -
protocol IHistoricalView {
    func instanceHistoricalViewFromNib() -> UIView
    func didSelectHistoricalRow(mainStack: StackViewController)
}


class HistoricalViewController: UIViewController {
    
    // MARK: - OUTLETS -
    
    @IBOutlet weak var mainStackView: AwesomeStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: - VARIABLES -
    private lazy var subViews = [IHistoricalView]()
    
    
}
// MARK: - LIFE CYCLE VIEW CONTROLLER -
extension HistoricalViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.isScrollEnabled = false
        self.configureSubViews()
        self.configureMainStackView()
    }
}

// MARK: - STACKVIEW DATASOURCE -
extension HistoricalViewController: AwesomeStackViewDataSource {
    func stackView(_ stackView: UIStackView, numberOfRowsInSection section: Int) -> Int {
        return self.subViews.count
    }
    
    func stackView(_ stackView: UIStackView, customSpacingForRow index: Int) -> Int {
        return 0
    }
    
    func stackView(_ stackView: UIStackView, viewForRowAt index: Int) -> UIView {
        return self.getViewforRow(index: index)
    }
}

// MARK: - STACKVIEW DELEGATE -
extension HistoricalViewController: AwesomeStackViewDelegate {
}


// MARK: - AUX METHODS -
extension HistoricalViewController {
    private func getViewforRow(index: Int) -> UIView {
        let emptyView = EmptyPageView().instanceExpenseSubViewFromNib() as! EmptyPageView
        emptyView.MessageLabel.text = NSLocalizedString("historicalEmptyMessageLabel", comment: "")
        return emptyView
    }
    
    private func configureSubViews() {
        self.subViews.append(EmptyPageView())
    }
    
    func configureMainStackView() {
        self.mainStackView.dataSource = self
        self.mainStackView.delegate = self
        self.mainStackView.initialize()
    }
}
