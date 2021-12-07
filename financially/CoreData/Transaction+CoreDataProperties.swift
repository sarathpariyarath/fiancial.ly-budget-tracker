//
//  Transaction+CoreDataProperties.swift
//  financially
//
//  Created by Sarath P on 07/12/21.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var dateAndTime: Date?
    @NSManaged public var note: String?
    @NSManaged public var amount: Float
    @NSManaged public var title: String?
    @NSManaged public var isIncome: Bool

}

extension Transaction : Identifiable {

}
