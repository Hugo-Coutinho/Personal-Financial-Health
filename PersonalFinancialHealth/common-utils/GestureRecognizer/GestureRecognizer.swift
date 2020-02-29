//
//  GestureRecognizer.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 20/02/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import UIKit

class GestureRecognizer {
    class func addGesture(view: UIView, target: Any, action: Selector) {
        let tapGesture = UITapGestureRecognizer(target: target, action: action)
        view.addGestureRecognizer(tapGesture)
    }
}
