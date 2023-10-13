//
//  UserFoods+CoreDataProperties.swift
//  CalorieTracker03
//
//  Created by LMD User on 10/12/23.
//  Copyright © 2023 mac. All rights reserved.
//
//

import Foundation
import CoreData


extension UserFoods {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserFoods> {
        return NSFetchRequest<UserFoods>(entityName: "UserFoods")
    }

    @NSManaged public var food_date: Date?
    @NSManaged public var food_name: String?
    @NSManaged public var food_type: String?
    @NSManaged public var serving: Int16
    @NSManaged public var meal_type: String?
    @NSManaged public var user_id: UUID?
    @NSManaged public var calorie_in: Float

    
    func convertToFood() -> userFoods
    {
        return userFoods(food_date: self.food_date, food_name: self.food_name, food_type: self.food_type ,serving: self.serving, meal_type: self.meal_type , user_id: self.user_id ,calorie_in: self.calorie_in)
    }
}
