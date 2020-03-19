//
//  StackViewController.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 06/08/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import UIKit


// MARK: - DATASOURCE -
@objc protocol StackViewDataSource : NSObjectProtocol {
    
    func stackView(_ stackView: UIStackView, numberOfRowsInSection section: Int) -> Int
    func stackView(_ stackView: UIStackView, customSpacingForRow index: Int) -> Int
    func stackView(_ stackView: UIStackView, viewForRowAt index: Int) -> UIView
    @objc optional func stackView(_ stackView: UIStackView, viewForRowSelectionAt index: Int) -> UIView?
    
}

// MARK: - DELEGATE -
@objc protocol StackViewDelegate: NSObjectProtocol {
    
    @objc optional func stackView(_ stackView: UIStackView, didSelectRowAt index: Int, view: UIView)
}

// MARK: - MAIN CLASS -
class StackViewController: UIStackView {
    
    @IBOutlet weak var dataSource: StackViewDataSource?
    @IBOutlet weak var delegate: StackViewDelegate?
    
    public func initialize() {
        self.setupStackView()
    }
}

// MARK: - DATASOURCE METHODS-
extension StackViewController {
    private func setupStackView() {
            self.setupChildren()
    }
    
    private func setupChildren() {
        guard let numberOfRows = self.dataSource?.stackView(self, numberOfRowsInSection: 0), numberOfRows > 0 else { return }
        self.removeChildrenIfNeeded(completed: {
            (0...(numberOfRows - 1)).forEach { (rowIndex) in
                guard let childView = self.dataSource?.stackView(self, viewForRowAt: rowIndex) else { return }
                 self.addChildView(childView, rowIndex)
                self.setupCustomSpacingForRow(childView: childView, index: rowIndex)
            }
        })
    }
    
    private func setupCustomSpacingForRow(childView: UIView, index: Int) {
        guard let spacingForRow = self.dataSource?.stackView(self, customSpacingForRow: index) else { return }
        self.setCustomSpacing(CGFloat(integerLiteral: spacingForRow), after: childView)
    }

    private func removeChildrenIfNeeded(completed: @escaping () -> Void) {
        if self.arrangedSubviews.count > 0 {
            self.removeChildrenViews(removalCompleted: { completed() })
        } else {
            completed()
        }
    }
    
    private func removeChildrenViews(removalCompleted: @escaping () -> Void) {
          self.arrangedSubviews.forEach { (arrangedSubview) in
            UIView.animate(withDuration: 0.4, animations: {
                arrangedSubview.alpha = 0
            }, completion: { animationCompleted in
                self.removeArrangedSubview(arrangedSubview)
                if self.arrangedSubviews.count == 0 {
                    DispatchQueue.main.async(execute: { removalCompleted() })
                }
            })
        }
    }
    
    private func addChildView(_ childView: UIView, _ rowIndex: Int) {
        childView.tag = rowIndex
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.selectView))
        childView.addGestureRecognizer(tapGesture)
        self.addChildView(childView: childView, at: rowIndex)
    }
}

// MARK: - DELEGATE METHODS -
extension StackViewController {
    public func addChildView(childView: UIView, at rowIndex: Int) {
        childView.tag = rowIndex
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.selectView))
        childView.addGestureRecognizer(tapGesture)
        childView.alpha = 0.2
        UIView.animate(withDuration: 0.4,
                       animations: {
                        childView.alpha = 0.4
                        self.insertArrangedSubview(childView, at: rowIndex)
                        self.setupCustomSpacingForRow(childView: childView, index: rowIndex)
        }) { (animationCompleted) in
            self.arrangedSubviews[rowIndex].alpha = 1
        }
    }
    
    @objc private func selectView(_ sender: AnyObject) {
        let senderTag = sender.view.tag
        guard let arrangedSubview = self.arrangedSubviews.filter({$0.tag == senderTag}).first else { return }
        self.delegate?.stackView?(self, didSelectRowAt: senderTag, view: arrangedSubview)
    }
    
    public func viewForRow(at index: Int) -> UIView? {
        guard let arrangedSubview = self.arrangedSubviews.filter({$0.tag == index}).first else { return nil }
        return arrangedSubview
    }
    
    public func removeChild(at index: Int) {
        guard let child = self.arrangedSubviews.filter({$0.tag == index}).first else { return }
        UIView.animate(withDuration: 0.4, animations: {
            child.alpha = 0
        }, completion: { animationCompleted in
            self.removeArrangedSubview(child)
            child.removeFromSuperview()
        })
    }
    
    public func removeChild(child: UIView) {
        guard self.arrangedSubviews.contains(child) else { return }
        UIView.animate(withDuration: 0.4, animations: {
            child.alpha = 0
        }, completion: { animationCompleted in
            self.removeArrangedSubview(child)
            child.removeFromSuperview()
        })
    }
    
    public func removeAll() {
        guard !self.arrangedSubviews.isEmpty else { return }
        self.arrangedSubviews.forEach({ (current) in
            self.removeChild(child: current)
        })
    }
    
    public func reloadStackView() {
        self.setupStackView()
    }
}

