//
//  Date.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 21/03/20.
//  Copyright © 2020 Hugo. All rights reserved.
//

import Foundation

extension Date {
    func getFormattedDate() -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = self.getDateFormat()
        
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
    
    static func IsTodayANewMonth() -> Bool {
        return Calendar.current.component(.day, from: Date()) == 1
    }
}

// MARK: - AUX FUNCTIONS -
extension Date {
    func getDateFormat() -> String {
        return Locale.current.languageCode == "en" ? "MMM dd,yyyy HH:mm" : "dd/MM/yyyy HH:mm"
        
    }
}
