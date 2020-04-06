//
//  UIColor.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 04/07/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    class func skyBlue() -> UIColor { // #009ACD
        return UIColor(red: 0/255, green: 154/255, blue: 205/255, alpha: 0.97)
    }
    
    class func ExpenseGreen() -> UIColor { // #55B235
        return UIColor(red: 85/255, green: 178/255, blue: 53/255, alpha: 0.45)
    }
    
    class func ExpenseRed() -> UIColor { // #EC0028
        return UIColor(red: 236/255, green: 0/255, blue: 40/255, alpha: 0.60)
    }
    
    class func backgroundGrayColor() -> UIColor { // #E5E5E5
        return UIColor(red: 229/255, green: 229/255, blue: 229/255, alpha: 1.0)
    }
}

