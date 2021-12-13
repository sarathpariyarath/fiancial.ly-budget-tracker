//
//  Transaction+CoreDataProperties.swift
//  financially
//
//  Created by Sarath P on 10/12/21.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var amount: Float
    @NSManaged public var dateAndTime: Date?
    @NSManaged public var image: Data?
    @NSManaged public var isIncome: Bool
    @NSManaged public var note: String?
    @NSManaged public var title: String?
    @NSManaged public var category: String?
    @NSManaged public var incomeCategory: IncomeCategory?
    @NSManaged public var expenseCategory: ExpenseCategory?

}

extension Transaction : Identifiable {

}
