//
//  Transaction+CoreDataProperties.swift
//  financially
//
//  Created by Sarath P on 09/12/21.
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
    @NSManaged public var isIncome: Bool
    @NSManaged public var note: String?
    @NSManaged public var title: String?

}

extension Transaction : Identifiable {

}
