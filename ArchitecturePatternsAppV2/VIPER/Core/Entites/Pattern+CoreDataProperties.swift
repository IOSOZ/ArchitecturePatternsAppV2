//
//  Pattern+CoreDataProperties.swift
//  ArchitecturePatternsAppV2
//
//  Created by Олег Зуев on 13.11.2025.
//
//

import Foundation
import CoreData


extension Pattern {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pattern> {
        return NSFetchRequest<Pattern>(entityName: "Pattern")
    }

    @NSManaged public var id: UUID
    @NSManaged public var type: String
    @NSManaged public var name: String
    @NSManaged public var commentary: String?
    @NSManaged public var viewCounter: Int16
    @NSManaged public var isFavorite: Bool
    @NSManaged public var image: Data?

}

extension Pattern : Identifiable {

}
