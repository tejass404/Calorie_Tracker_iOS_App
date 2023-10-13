//
//  UserActivityManager.swift
//  CalorieTracker03
//
//  Created by LMD User on 10/11/23.
//  Copyright © 2023 mac. All rights reserved.
//

import Foundation
import CoreData

struct UserActivityManager
{
    private let  userActivitiesRepo = UserActivitiesRepository()
    
    func createActivity(activity : userActivities){
        userActivitiesRepo.createActivity(activities: activity)
    }
    func getActivityById(byIdentifier user_id : UUID) -> [userActivities]?{
        return userActivitiesRepo.getActivityById(byIdentifier: user_id)
    }
    func getActivityByIdAndDate(user_id: UUID, dateString: String) -> [userActivities]?{
        return userActivitiesRepo.getActivityByIdAndDate(user_id: user_id, dateString: dateString)
    }
}
