//
//  Entity+CoreDataProperties.swift
//  CalorieTracker03
//
//  Created by mac on 05/10/23.
//  Copyright © 2023 mac. All rights reserved.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var weight: Int16
    @NSManaged public var height: Int16
    @NSManaged public var age: Int16
    @NSManaged public var gender: String?
    @NSManaged public var bmr: Int16

}
