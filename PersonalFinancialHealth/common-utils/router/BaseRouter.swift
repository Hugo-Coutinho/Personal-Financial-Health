//
//  BaseRouter.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 10/02/20.
//  Copyright © 2020 Hugo. All rights reserved.
//

import Foundation
import UIKit

class BaseRouter {
    class func createModule<T: UIViewController>(viewController: T.Type) -> T {
        return UIStoryboard.getViewController(viewController)
    }
    
    class func goTo<T>(module: T) where T : UIViewController {
        Coordinator.setVisibleScreen(vc: module)
    }
}
