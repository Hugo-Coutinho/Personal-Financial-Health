//
//  ExpenseRouter.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 10/07/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import UIKit

class ExpenseRouter: BaseRouter {
    // MARK: - OVERRIDE -
    override class func createModule() -> ExpenseViewController {
        return UIStoryboard.getViewController(ExpenseViewController.self)
    }
    
    // MARK: - PUSH VIEW CONTROLLER -
    static func navigateTo<T>(module: T) where T : UIViewController {
        self.goTo(module: module)
    }
}
