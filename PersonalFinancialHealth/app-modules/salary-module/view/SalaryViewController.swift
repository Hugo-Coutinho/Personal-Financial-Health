//
//  SalaryViewController.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 18/02/20.
//  Copyright © 2020 Hugo. All rights reserved.
//

import UIKit

class SalaryViewController: UIViewController {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var reusableButton: ReusableButton!
    @IBOutlet weak var textFieldNetSalary: UITextField!
    @IBOutlet weak var textFieldUsefullySalary: UITextField!
    @IBOutlet weak var netSalary: UILabel!
    @IBOutlet weak var usefullySalary: UILabel!
    
    // MARK: - VARIABLES -
    private lazy var presenter: SalaryPresenterInput = SalaryPresenter.make(view: self)
    private let zeroNetSalary = Constant.view.salaryView.zeroNetSalary
    
    
    // MARK: - OVERRIDE LIFECYCLE -
    override func viewDidLoad() {
        super.viewDidLoad()
        GestureRecognizer.addGesture(view: self.reusableButton, target: self, action: #selector(self.saveSalary(_:)))
    }
    
    override func viewWillLayoutSubviews() {
        self.reusableButton.button.setTitle(NSLocalizedString("saveButton", comment: ""), for: .normal)
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
    
    func loadNetSalary() {
        self.presenter.loadNetSalary()
    }
    
    private func cleanTextFields() {
      self.textFieldNetSalary.text = ""
        self.textFieldUsefullySalary.text = ""
    }
    
    private func updateNetLabel() {
        let netSalaryFormatString = NSLocalizedString("netSalary", comment: "")
        
        guard let netSalary = self.textFieldNetSalary.text,
            let netSalaryResultDouble = Double(netSalary)  else { self.netSalary.text = self.zeroNetSalary; return }
        
        self.netSalary.text = String.localizedStringWithFormat(netSalaryFormatString, netSalaryResultDouble)
    }
    
    private func updateUsefullyLabel() {
        let usefullySalaryFormatString = NSLocalizedString("usefullySalary", comment: "")
        
        guard let usefullySalary = self.textFieldUsefullySalary.text,
            let usefullySalaryResultDouble = Double(usefullySalary)  else { self.usefullySalary.text = self.zeroNetSalary; return }
        
        self.usefullySalary.text = String.localizedStringWithFormat(usefullySalaryFormatString, usefullySalaryResultDouble)
    }
}

// MARK: - PRESENTER OUTPUT -
extension SalaryViewController: SalaryPresenterToView {
    func invalidInput() {
        Alert.presentOkNativeAlert(title: "Error", message: NSLocalizedString(Constant.view.salaryView.alertInvalidInput, comment: "alert invalid user input"), viewController: self)
    }
    
    func validInput() {
        let title = NSLocalizedString(Constant.view.salaryView.successInsertSalaryTitle, comment: "")
        let message = NSLocalizedString(Constant.view.salaryView.successInsertSalaryMessage, comment: "")
        
        self.presenter.fetchNetSalary(netInputValue: self.textFieldNetSalary.text, usefullyInputValue: self.textFieldUsefullySalary.text)
        Alert.presentOkNativeAlert(title: title, message: message, viewController: self)
        self.cleanTextFields()
    }
    
    func didNotLoadSalary() {
        self.netSalary.text = NSLocalizedString(self.zeroNetSalary, comment: "")
        self.usefullySalary.text = NSLocalizedString(self.zeroNetSalary, comment: "")
    }
    
    func didLoadSalary(salary: SalaryModel) {
        let netSalaryFormatString = NSLocalizedString("netSalary", comment: "")
        let usefullySalaryFormatString = NSLocalizedString("usefullySalary", comment: "")
        
        self.netSalary.text = String.localizedStringWithFormat(netSalaryFormatString, salary.net)
        self.usefullySalary.text = String.localizedStringWithFormat(usefullySalaryFormatString, salary.usefully)
    }
    
    func updateSalaryLabels() {
        self.updateNetLabel()
        self.updateUsefullyLabel()
    }
    
    func showFailToSaveSalaryAlert() {
        Alert.presentOkNativeAlert(title: "Error", message: NSLocalizedString(Constant.view.salaryView.alertFailToSaveSalary, comment: "alert fail to save salary"), viewController: self)
    }
}
