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
    
    class func getVisibileViewController<T: UIViewController>(viewController: T.Type) -> T?  {
        let root: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
        guard let rootViewController = root,
            let nav = (rootViewController as? UINavigationController),
        let visibleViewController = nav.visibleViewController else { return T()}
            return  visibleViewController as? T
    }
}
