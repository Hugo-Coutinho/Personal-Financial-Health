//
//  Button.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 18/02/20.
//  Copyright © 2020 Hugo. All rights reserved.
//

import UIKit

class ReusableButton: UIView {
    
    // MARK: - OUTLETS -
    @IBOutlet weak var button: UIButton!
    
    // MARK: - CONSTANTS -
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
    }
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

