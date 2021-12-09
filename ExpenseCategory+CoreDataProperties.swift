//
//  ExpenseCategory+CoreDataProperties.swift
//  financially
//
//  Created by Sarath P on 09/12/21.
//
//

import Foundation
import CoreData


extension ExpenseCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpenseCategory> {
        return NSFetchRequest<ExpenseCategory>(entityName: "ExpenseCategory")
    }

    @NSManaged public var categoryName: String?

}

extension ExpenseCategory : Identifiable {

}
