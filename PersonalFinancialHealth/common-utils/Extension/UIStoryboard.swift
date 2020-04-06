//
//  UIStoryboard.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 09/07/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    class func getViewController<T: UIViewController>(_ viewController: T.Type) -> T {
        let storyboard = UIStoryboard(name: String(describing: viewController).replace("ViewController", withString: ""), bundle: nil)
        
        return storyboard.instantiateViewController(withIdentifier: String(describing: viewController)) as! T
    }
}

