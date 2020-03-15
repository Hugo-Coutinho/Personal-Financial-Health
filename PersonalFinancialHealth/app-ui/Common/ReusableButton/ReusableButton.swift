//
//  Button.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 18/02/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import UIKit

class ReusableButton: UIView {
    
    @IBOutlet weak var button: UIButton!
    
    let nibName = "ReusableButton"

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    func commonInit() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
//        contentView = view
    }
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

