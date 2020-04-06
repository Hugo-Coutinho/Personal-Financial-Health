//
//  GlobalRouter.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 03/07/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import Foundation
import UIKit


class Coordinator {
    
    // MARK: - DECLARATIONS
    public static var navController: UINavigationController? = nil
    
    // MARK: - PUBLIC FUNCTIONS
    public class func setVisibleScreen<T>(vc: T) where T : UIViewController {
        guard let nav = navController else { return }
        guard !nav.viewControllers.isEmpty,
            nav.viewControllers.filter({ $0 is T }).count > 0
            else { pushNewScreen(vc: vc); return }
        swapScreen(vc: vc)
    }
}

// MARK: - AUX FUNCTIONS
extension Coordinator {
    private class func pushNewScreen<T>(vc: T) where T : UIViewController {
        navController!.pushViewController(vc, animated: true)
    }
    
    private class func swapScreen<T>(vc: T) where T : UIViewController {
        navController!.viewControllers.removeAll(where: { $0 is T })
        navController!.pushViewController(vc, animated: true)
    }
}
