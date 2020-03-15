//
//  Alert.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 10/03/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import UIKit
import Foundation

class Alert {
    class func presentOkNativeAlert(title: String, message: String, viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)
        viewController.present(alertController, animated: true, completion:nil)
    }
}
