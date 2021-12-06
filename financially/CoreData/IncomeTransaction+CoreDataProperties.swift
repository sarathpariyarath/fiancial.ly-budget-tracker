//
//  IncomeTransaction+CoreDataProperties.swift
//  financially
//
//  Created by Sarath P on 06/12/21.
//
//

import Foundation
import CoreData


extension IncomeTransaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IncomeTransaction> {
        return NSFetchRequest<IncomeTransaction>(entityName: "IncomeTransaction")
    }

    @NSManaged public var dateAndTime: Date?
    @NSManaged public var note: String?
    @NSManaged public var amount: Float
    @NSManaged public var title: String?

}

extension IncomeTransaction : Identifiable {

}
