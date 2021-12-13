//
//  ExpenseCategory+CoreDataProperties.swift
//  financially
//
//  Created by Sarath P on 10/12/21.
//
//

import Foundation
import CoreData


extension ExpenseCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExpenseCategory> {
        return NSFetchRequest<ExpenseCategory>(entityName: "ExpenseCategory")
    }

    @NSManaged public var categoryName: String?
    @NSManaged public var transaction: NSSet?

}

// MARK: Generated accessors for transaction
extension ExpenseCategory {

    @objc(addTransactionObject:)
    @NSManaged public func addToTransaction(_ value: Transaction)

    @objc(removeTransactionObject:)
    @NSManaged public func removeFromTransaction(_ value: Transaction)

    @objc(addTransaction:)
    @NSManaged public func addToTransaction(_ values: NSSet)

    @objc(removeTransaction:)
    @NSManaged public func removeFromTransaction(_ values: NSSet)

}

extension ExpenseCategory : Identifiable {

}
