//
//  UserFoodManager.swift
//  CalorieTracker03
//
//  Created by LMD User on 10/12/23.
//  Copyright © 2023 mac. All rights reserved.
//

import Foundation
import CoreData

struct UserFoodManager
{
    private let  userFoodsRepo = UserFoodsRepository()
    
    func createFood(food : userFoods){
        userFoodsRepo.createFood(foods: food )
    }
    func getFoodById(byIdentifier user_id : UUID) -> [userFoods]?{
        return userFoodsRepo.getFoodById(byIdentifier: user_id)
    }
    func getFoodByIdAndDate(user_id: UUID, dateString: String) -> [userFoods]?{
        return userFoodsRepo.getFoodByIdAndDate(user_id: user_id, dateString: dateString)
    }
}
