//
//  Date.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 21/03/20.
//  Copyright © 2020 BRQ. All rights reserved.
//

import Foundation

extension Date {
    func getFormattedDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "MMM dd,yyyy"
        
        let date: Date = self
        print("Date",dateFormatterPrint.string(from: date))
        return dateFormatterPrint.string(from: date);
    }
}
