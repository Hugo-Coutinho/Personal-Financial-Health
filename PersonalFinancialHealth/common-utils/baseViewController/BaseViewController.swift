//
//  BaseViewController.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 04/07/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//           self.prepareNavigationBar()
    }

    func prepareNavigationBar() {

//        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: screenSize.width, height: 80))
        
        UIApplication.shared.statusBarStyle = .lightContent
        Coordinator.navController?.navigationBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
        Coordinator.navController?.navigationBar.barStyle = .black
        Coordinator.navController?.navigationBar.isTranslucent = false
        
        // Customize Background Bar Color
        Coordinator.navController?.navigationBar.barTintColor = UIColor.skyBlue()
        
        // Customize Tint Color
        Coordinator.navController?.navigationBar.tintColor = UIColor.skyBlue()
        Coordinator.navController?.navigationBar.backgroundColor = UIColor.skyBlue()
        
//        self.view.addSubview(Coordinator.navController?.navigationBar)
        
//        let screenSize: CGRect = UIScreen.main.bounds
//        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: screenSize.width, height: screenSize.height))
//        let navItem = UINavigationItem(title: "Personal Financial Health")
//        navBar.setItems([navItem], animated: false)
//        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
//        navBar.barTintColor = UIColor.skyBlue()
//        self.view.addSubview(navBar)
    }
}
