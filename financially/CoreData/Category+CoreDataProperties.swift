//
//  Category+CoreDataProperties.swift
//  financially
//
//  Created by Sarath P on 07/12/21.
//
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category")
    }

    @NSManaged public var isIncome: Bool
    @NSManaged public var categoryName: String?

}

extension Category : Identifiable {

}
