//
//  CDUserDetails+CoreDataProperties.swift
//  CalorieTracker03
//
//  Created by mac on 06/10/23.
//  Copyright © 2023 mac. All rights reserved.
//
//

import Foundation
import CoreData


extension CDUserDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUserDetails> {
        return NSFetchRequest<CDUserDetails>(entityName: "CDUserDetails")
    }

    @NSManaged public var age: Int16
    @NSManaged public var bmr: Float
    @NSManaged public var gender: String?
    @NSManaged public var height: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var weight: Float
    
    func convertToUser() -> UserDetails
    {
        return UserDetails(age: self.age, bmr: self.bmr,gender: self.gender ,height: self.height,id: self.id,name: self.name,weight: self.weight)
    }
}
