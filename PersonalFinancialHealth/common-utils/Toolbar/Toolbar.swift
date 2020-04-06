//
//  Toolbar.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 06/04/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import Foundation
import UIKit

extension UIToolbar {
    class func loadDoneButton() -> UIToolbar {
        guard let currentView = UIViewController.getVisibileViewController(viewController: UIViewController.self)?.view else { return UIToolbar()}
            let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: currentView.frame.size.width, height: currentView.frame.size.height)))
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn = UIBarButtonItem(title: NSLocalizedString("keyboardDoneButton", comment: ""), style: .done, target: target, action: #selector(toolbar.dismissKeyboard))
            toolbar.setItems([flexSpace, doneBtn], animated: false)
            toolbar.sizeToFit()
            return toolbar
        }
    
    @objc private func dismissKeyboard() {
        UIViewController.getVisibileViewController(viewController: UIViewController.self)?.view.endEditing(true)
    }
}

