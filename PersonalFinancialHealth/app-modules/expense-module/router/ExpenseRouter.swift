//
//  ExpenseRouter.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 10/07/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import UIKit

class ExpenseRouter {
    static func createModule() -> ExpenseViewController {
        return UIStoryboard.getViewController(ExpenseViewController.self)
    }
}
