//
//  UserActivitiesRepository.swift
//  CalorieTracker03
//
//  Created by LMD User on 10/11/23.
//  Copyright © 2023 mac. All rights reserved.
//

import Foundation
import CoreData

protocol ActivityRepository {
    
    func createActivity(activities : userActivities)
    func getActivityById(byIdentifier user_id: UUID) -> [userActivities]?
}

struct UserActivitiesRepository : ActivityRepository
{
    func getActivityById(byIdentifier user_id: UUID) -> [userActivities]? {
        let result = getUserActivities(byIdentifier: user_id)
        var foods: [userActivities]=[]
        
        result?.forEach({ (userFood) in
            foods.append(userFood.convertToActivity())
        })
        return foods
       
    }
    
    func getActivityByIdAndDate(user_id: UUID, dateString: String) -> [userActivities]? {
        let result = getUserActivities(byIdentifier: user_id)

        // Convert the dateString to a Date object
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Use the appropriate date format
        if let date = dateFormatter.date(from: dateString) {
            var activities: [userActivities] = []
            result?.forEach { (userActivity) in
                // Check if the activity date matches the provided date
                if let activityDate = userActivity.activity_date, Calendar.current.isDate(activityDate, inSameDayAs: date) {
                    activities.append(userActivity.convertToActivity())
                }
            }
            return activities
        }

        return nil // Return nil if date conversion fails
    }

    
    func createActivity(activities: userActivities) {
        
        let user_activities = UserActivities(context: PersistentStorage.shared.context)
        user_activities.activity_date = activities.activity_date
        user_activities.activity_name = activities.activity_name
        user_activities.activity_type = activities.activity_type
        user_activities.met_value = activities.met_value
        user_activities.user_id = activities.user_id
        user_activities.activity_duration = activities.activity_duration
        user_activities.calorie_out = activities.calorie_out
        
        PersistentStorage.shared.saveContext()
    }
    
    private func getUserActivities(byIdentifier id: UUID) -> [UserActivities]?
    {
        let fetchRequest = NSFetchRequest<UserActivities>(entityName: "UserActivities")
        let predicate = NSPredicate(format: "user_id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        do{
            let result = try PersistentStorage.shared.context.fetch(fetchRequest)
            guard result != nil else {return nil}
            return result
        }catch let error{
            debugPrint(error)
            return nil
        }
    }
}
