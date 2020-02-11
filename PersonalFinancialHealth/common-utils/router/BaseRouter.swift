//
//  BaseRouter.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 10/02/20.
//  Copyright © 2020 BRQ. All rights reserved.
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
