//
//  UIView.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 10/07/19.
//  Copyright © 2019 Hugo. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    class func instanceFromNib(nibName: String) -> UIView {
        return UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    class func instanceFromNib(nibName: String, index: Int) -> UIView {
        return UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil)[index] as! UIView
    }
    
    class func BlurView() -> UIView {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.backgroundColor = UIColor.skyBlue()
        blurView.alpha = 0.6
        blurView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width).isActive = true
        blurView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height).isActive = true
        return blurView
    }

    open func configureAspectRatio(toItem  item: UIView, multiplierFirst: Float, multiplierSecond: Float) -> NSLayoutConstraint {
            return NSLayoutConstraint(item: self,
            attribute: .height,
            relatedBy: .equal,
            toItem: item,
            attribute: .width,
            multiplier: CGFloat(multiplierFirst) / CGFloat(multiplierSecond),
            constant: 0)
    }
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
}
