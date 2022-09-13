//
//  CardEntity+CoreDataProperties.swift
//  CardsOut
//
//  Created by Apurva Acharya on 2022-07-08.
//
//

import Foundation
import CoreData
import UIKit


extension CardEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardEntity> {
        return NSFetchRequest<CardEntity>(entityName: "CardEntity")
    }

    @NSManaged public var id: String
    @NSManaged public var title: String?
    @NSManaged public var fieldNames: [String]
    @NSManaged public var fieldValues: [String]
    @NSManaged public var edited: Bool
    @NSManaged public var deleteTheCard: Bool
    @NSManaged public var backgroundColor: UIColor
    @NSManaged public var textColor: UIColor
    @NSManaged public var descript: String
    @NSManaged public var hasDescript: Bool
}

extension CardEntity : Identifiable {

}
