//
//  SalaryModel.swift
//  PersonalFinancialHealth
//
//  Created by Hugo on 20/02/20.
//  Copyright © 2020 Hugo. All rights reserved.
//

import Foundation
import CoreData

// MARK: - DECLARATIONS & INITIALIZATIONS -
class SalaryModel {
    var net: Double
    var usefully: Double
    
    init(net: Double, usefully: Double) {
        self.net = net
        self.usefully = usefully
    }
}

// MARK: - MANAGE OBJECT CONVERSION -
extension SalaryModel: ManagedObjectConvertible {
typealias ManagedObject = SalaryMO
    
    func toManagedObject(in context: NSManagedObjectContext) -> SalaryMO {
        let salaryMO = SalaryMO(context: context)
        salaryMO.net = self.net
        salaryMO.usefully = self.usefully
        return salaryMO
    }
}

// MARK: - MODEL CONVERSION -
extension SalaryModel: ManagedObjectProtocol {
    typealias Entity = SalaryModel
    
    static func toEntity(mo: SalaryMO) -> SalaryModel {
        return SalaryModel(net: mo.net, usefully: mo.usefully)
    }
}


