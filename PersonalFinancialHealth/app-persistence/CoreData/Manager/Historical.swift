//
//  Historical.swift
//  PersonalFinancialHealth
//
//  Created by BRQ on 09/07/19.
//  Copyright © 2019 BRQ. All rights reserved.
//

import Foundation
import CoreData

class HistoricalManager {
    
    // MARK: - DECLARATIONS -
    private var fetchRequest:NSFetchRequest<Historical> = Historical.fetchRequest()
    private var sortDescriptor = NSSortDescriptor(key: Constant.persistence.sortDescriptor, ascending: true)
}

// MARK: - DATABASE FUNCTIONS
extension HistoricalManager {
    
}
