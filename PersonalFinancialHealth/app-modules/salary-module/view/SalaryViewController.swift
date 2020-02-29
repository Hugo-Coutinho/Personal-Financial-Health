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
    
    
    // MARK: - OVERRIDE LIFECYCLE -
    override func viewDidLoad() {
        super.viewDidLoad()
        GestureRecognizer.addGesture(view: self.reusableButton, target: self, action: #selector(self.saveSalary(_:)))
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
        let alertController = UIAlertController(title: "Error", message: "please, input all the values to submit it.", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
    
    func validInput() {
        self.presenter.fetchNetSalary(netInputValue: self.textFieldNetSalary.text, usefullyInputValue: self.textFieldUsefullySalary.text)
    }
    
    func didNotLoadNetSalary() {
        self.netSalary.text = "R$ 00,00"
    }
    
    func didLoadNetSalary(net: Double) {
        let moneyValue = "R$ 00,00"
        let netSalaryResult = moneyValue.replace("00,00", withString: String(net))
        
        self.netSalary.text = netSalaryResult
    }
    
    func updateNetSalaryLabel() {
        let moneyValue = "R$ 00,00"
        let netSalaryResult = moneyValue.replace("00,00", withString: self.textFieldNetSalary.text ?? "00.00")
        
        self.netSalary.text = netSalaryResult
    }
    
    func showFailToSaveSalaryAlert() {
        let alertController = UIAlertController(title: "Error", message: "Something went wrong, please try later.", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion:nil)
    }
}
