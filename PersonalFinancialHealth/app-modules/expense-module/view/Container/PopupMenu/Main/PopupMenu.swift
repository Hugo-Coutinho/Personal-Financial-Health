//
//  Blur.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 07/08/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import UIKit

class PopupMenu: UIView {
    
    override func awakeFromNib() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
        self.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height).isActive = true
        self.insertSubview(UIView.BlurView(), at: 0)
    }
}
