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
    
    
    public class func setVisiblePage<T>(vc: T) where T : UIViewController {
        guard let nav = navController else { return }
        guard !nav.viewControllers.isEmpty,
            nav.viewControllers.contains(vc),
            let vcIndex = nav.viewControllers.firstIndex(where: { $0 is T }) else { pushNewPage(vc: vc); return }
        swapPage(vc: vc, pageIndex: vcIndex)
    }
}


// MARK: - AUX FUNCTIONS
extension Coordinator {
    private class func pushNewPage<T>(vc: T) where T : UIViewController {
        navController!.pushViewController(vc, animated: true)
    }
    
    private class func swapPage<T>(vc: T, pageIndex: Int) where T : UIViewController {
        navController!.viewControllers.swapAt(pageIndex, 0)
    }
}
