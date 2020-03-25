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
    
    func getDaysLeftFromMonth() -> Double {
        let today = Calendar.current.component(.day, from: self)
        let dateInterval = Calendar.current.dateInterval(of: .month, for: self)?.end
        let monthLastDate = Calendar.current.date(byAdding: .day, value: -1, to: dateInterval!)
        let endDayOfMonth = Calendar.current.component(.day, from: monthLastDate!)
        return Double(endDayOfMonth - today)
    }
}
