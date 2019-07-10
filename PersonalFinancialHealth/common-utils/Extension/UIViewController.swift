//
//  UIViewController.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 10/07/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    public func configureNavigationItem(hidesBackButton: Bool) {
        Coordinator.navController!.topViewController?.navigationItem.hidesBackButton = hidesBackButton
        Coordinator.navController!.topViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
