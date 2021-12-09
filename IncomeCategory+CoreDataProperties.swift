//
//  IncomeCategory+CoreDataProperties.swift
//  financially
//
//  Created by Sarath P on 09/12/21.
//
//

import Foundation
import CoreData


extension IncomeCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IncomeCategory> {
        return NSFetchRequest<IncomeCategory>(entityName: "IncomeCategory")
    }

    @NSManaged public var categoryName: String?

}

extension IncomeCategory : Identifiable {

}
