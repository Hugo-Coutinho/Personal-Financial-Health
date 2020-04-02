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
    
    class func presentYesNoNativeAlert(title: String, message: String, viewController: UIViewController, yesClicked: @escaping () -> Void, noClicked: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let yes = NSLocalizedString("alertYesTitle", comment: "")
        let no = NSLocalizedString("alertNoTitle", comment: "")
        
        
        alertController.addAction(UIAlertAction(title: yes, style: .default, handler: { (action: UIAlertAction!) in
            print("Yes clicked")
            yesClicked()
        }))
        
        alertController.addAction(UIAlertAction(title: no, style: .cancel, handler: { (action: UIAlertAction!) in
            print("No clicked")
            noClicked()
        }))
        viewController.present(alertController, animated: true, completion:nil)
    }
    
}
