//
//  SalaryViewController.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 18/02/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import UIKit

class SalaryViewController: UIViewController {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var reusableButton: ReusableButton!
    @IBOutlet weak var textFieldNetSalary: UITextField!
    @IBOutlet weak var textFieldUsefullySalary: UITextField!
    @IBOutlet weak var netSalary: UILabel!
    
    // MARK: - VARIABLES -
    private lazy var presenter: SalaryPresenterInput = SalaryPresenter.make(view: self)
    private let zeroNetSalary = Constant.view.salaryView.zeroNetSalary
    
    
    // MARK: - OVERRIDE LIFECYCLE -
    override func viewDidLoad() {
        super.viewDidLoad()
        GestureRecognizer.addGesture(view: self.reusableButton, target: self, action: #selector(self.saveSalary(_:)))
    }
    
    override func viewWillLayoutSubviews() {
        self.reusableButton.button.setTitle("Save", for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadNetSalary()
    }
}

// MARK: - AUX METHODS -
extension SalaryViewController {
    @objc private func saveSalary(_ sender: Any) {
        self.presenter.validateInputValues(netInputValue: self.textFieldNetSalary.text, usefullyInputValue: self.textFieldUsefullySalary.text)
    }
}

// MARK: - AUX METHODS -
extension SalaryViewController {
    func loadNetSalary() {
        self.presenter.loadNetSalary()
    }
}

// MARK: - PRESENTER OUTPUT -
extension SalaryViewController: SalaryPresenterToView {
    func invalidInput() {
        Alert.presentOkNativeAlert(title: "Error", message: Constant.view.salaryView.alertInvalidInput, viewController: self)
    }
    
    func validInput() {
        self.presenter.fetchNetSalary(netInputValue: self.textFieldNetSalary.text, usefullyInputValue: self.textFieldUsefullySalary.text)
    }
    
    func didNotLoadNetSalary() {
        self.netSalary.text = self.zeroNetSalary
    }
    
    func didLoadNetSalary(net: Double) {
        let netSalaryResult = String(net).formatValueWithR$()
        
        self.netSalary.text = netSalaryResult
    }
    
    func updateNetSalaryLabel() {
        let netSalaryResult = self.textFieldNetSalary.text?.formatValueWithR$()
        
        self.netSalary.text = netSalaryResult
    }
    
    func showFailToSaveSalaryAlert() {
        Alert.presentOkNativeAlert(title: "Error", message: Constant.view.salaryView.alertFailToSaveSalary, viewController: self)
    }
}
