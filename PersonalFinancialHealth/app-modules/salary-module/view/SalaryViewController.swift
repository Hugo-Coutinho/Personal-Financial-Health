//
//  SalaryViewController.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 18/02/20.
//  Copyright © 2020 Hugo. All rights reserved.
//

import UIKit
import AwesomeStackView

class SalaryViewController: UIViewController {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var reusableButton: ReusableButton!
    @IBOutlet weak var textFieldNetSalary: UITextField!
    @IBOutlet weak var textFieldUsefullySalary: UITextField!
    @IBOutlet weak var netSalary: UILabel!
    @IBOutlet weak var usefullySalary: UILabel!
    @IBOutlet weak var typeAvailableLabel: UILabel!
    @IBOutlet weak var typeNetSalaryLabel: UILabel!
    @IBOutlet weak var backgroundBlueView: UIView!
    @IBOutlet weak var salaryMainstackView: AwesomeStackView!
    @IBOutlet var formView: UIView!
    @IBOutlet var blankView: UIView!

    
    // MARK: - VARIABLES -
    private lazy var presenter: SalaryPresenterInput = SalaryPresenter.make(view: self)
    private let zeroNetSalary = Constant.view.salaryView.zeroNetSalary
    private var stackViews: [UIView] = []
    
    // MARK: - OVERRIDE LIFECYCLE -
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTextfields()
        GestureRecognizer.addGesture(view: self.reusableButton, target: self, action: #selector(self.saveSalary(_:)))
    }
    
    override func viewWillLayoutSubviews() {
        self.reusableButton.button.setTitle(NSLocalizedString("saveButton", comment: ""), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.loadNetSalary()
        self.stackViews = [self.backgroundBlueView, self.formView]
        self.salaryMainstackView.dataSource = self
        self.salaryMainstackView.initialize()
    }
}

// MARK: -  STACK VIEW DATA SOURCE -
extension SalaryViewController: AwesomeStackViewDataSource {
    func stackView(_ stackView: UIStackView, numberOfRowsInSection section: Int) -> Int {
        return self.stackViews.count
    }
    
    func stackView(_ stackView: UIStackView, customSpacingForRow index: Int) -> Int {
        return 0
    }
    
    func stackView(_ stackView: UIStackView, viewForRowAt index: Int) -> UIView {
        return getViewForRow(index)
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
    
    private func configureFormViewSetupVisibility(_ index: Int) {
        guard self.stackViews[index] == self.formView,
            !(self.isUserVisibilityIsTyping(index)) else { return }
            self.defaultVisibility()
    }
    
    private func isUserVisibilityIsTyping(_ index: Int) -> Bool {
        return index == 0
    }
    
    private func getViewForRow(_ index: Int) -> UIView {
        self.configureFormViewSetupVisibility(index)
        return self.stackViews[index]
    }
}

// MARK: - TEXT FIELD MANAGMENT FUNCTIONS -
extension SalaryViewController: UITextFieldDelegate {
    private func setupTextfields() {
        let toolbar = UIToolbar.loadDoneButton()
        self.textFieldNetSalary.inputAccessoryView = toolbar
        self.textFieldUsefullySalary.inputAccessoryView = toolbar
        self.textFieldNetSalary.delegate = self
        self.textFieldUsefullySalary.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.configureStackViewsUserDidBeginEditing()
        self.salaryMainstackView.reloadStackView()
        self.applyVisibilityUserIsTyping(textField)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.configureStackViewsUserDidEndEditing()
        self.salaryMainstackView.reloadStackView()
    }
    
    private func applyVisibilityUserIsTyping(_ textField: UITextField) {
        if textField.tag == 1 {
            self.typingNetSalaryVisibility()
        } else {
            self.typingUsefullySalaryVisibility()
        }
    }
    
    private func configureStackViewsUserDidBeginEditing() {
        [self.formView: 0, self.blankView: 1].forEach { (arg0) in
            let (key, currentIndex) = arg0
            guard let currentView = key else { return }
            self.addViewForIndex(view: currentView, index: currentIndex)
        }
    }
    
    private func configureStackViewsUserDidEndEditing() {
        [self.backgroundBlueView: 0, self.formView: 1].forEach { (arg0) in
            let (key, currentIndex) = arg0
            guard let currentView = key else { return }
            self.addViewForIndex(view: currentView, index: currentIndex)
        }
    }
    
    private func addViewForIndex(view: UIView, index: Int) {
        self.stackViews[index] = view
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

// MARK: - SALARY VISIBILITYS -
extension SalaryViewController {
    private func typingNetSalaryVisibility() {
        self.textFieldNetSalary.alpha = 1
        self.textFieldUsefullySalary.alpha = 0
        self.reusableButton.alpha = 0
        self.typeNetSalaryLabel.alpha = 1
        self.typeAvailableLabel.alpha = 0
    }
    
    private func typingUsefullySalaryVisibility() {
        self.textFieldNetSalary.alpha = 0
        self.textFieldUsefullySalary.alpha = 1
        self.reusableButton.alpha = 0
        self.typeNetSalaryLabel.alpha = 0
        self.typeAvailableLabel.alpha = 1
    }
    
    private func defaultVisibility() {
        self.textFieldNetSalary.alpha = 1
        self.textFieldUsefullySalary.alpha = 1
        self.reusableButton.alpha = 1
        self.typeNetSalaryLabel.alpha = 1
        self.typeAvailableLabel.alpha = 1
    }
}
