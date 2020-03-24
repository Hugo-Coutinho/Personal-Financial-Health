//
//  String.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 09/07/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation

extension String {
    func replace(_ target: String, withString: String) -> String
    {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func formatValueWithR$() -> String {
        let currency = "R$"
        let sign = String(self.prefix(1))
        guard self.count > 0,
            sign == "-" else { return "\(currency) \(self)" }
        let value = String(self.dropFirst())
        return "\(sign) \(currency) \(value)"
    }
}
