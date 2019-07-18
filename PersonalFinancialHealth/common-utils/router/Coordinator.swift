//
//  GlobalRouter.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 03/07/19.
//  Copyright © 2019 BRQ. All rights reserved.
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
            nav.viewControllers.filter({ $0 is T }).count > 0,
            let vcIndex = nav.viewControllers.firstIndex(where: { $0 is T })
            else { pushNewScreen(vc: vc); return }
        let topIndex = nav.viewControllers.firstIndex(of: nav.viewControllers.last!)!
        swapScreen(vcIndex: vcIndex, topIndex: topIndex)
    }
}


// MARK: - AUX FUNCTIONS
extension Coordinator {
    private class func pushNewScreen<T>(vc: T) where T : UIViewController {
        navController!.pushViewController(vc, animated: false)
    }
    
    private class func swapScreen(vcIndex: Int, topIndex: Int) {
        navController!.viewControllers.swapAt(vcIndex, topIndex)
    }
}
