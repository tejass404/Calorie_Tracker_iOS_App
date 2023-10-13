//
//  UserActivities+CoreDataProperties.swift
//  CalorieTracker03
//
//  Created by LMD User on 10/11/23.
//  Copyright © 2023 mac. All rights reserved.
//
//

import Foundation
import CoreData


extension UserActivities {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserActivities> {
        return NSFetchRequest<UserActivities>(entityName: "UserActivities")
    }

    @NSManaged public var activity_date: Date?
    @NSManaged public var activity_name: String?
    @NSManaged public var met_value: Float
    @NSManaged public var user_id: UUID?
    @NSManaged public var calorie_out: Float
    @NSManaged public var activity_duration: Float
    @NSManaged public var activity_type: String?

    func convertToActivity() -> userActivities
    {
        return userActivities(activity_date: self.activity_date,activity_name: self.activity_name ,met_value: self.met_value,user_id: self.user_id, calorie_out: self.calorie_out, activity_duration: self.activity_duration, activity_type: self.activity_type)
    }
}
