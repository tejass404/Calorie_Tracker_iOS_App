//
//  UserFoodsRepository.swift
//  CalorieTracker03
//
//  Created by LMD User on 10/12/23.
//  Copyright © 2023 mac. All rights reserved.
//

import Foundation
import CoreData

protocol FoodRepository {
    
    func createFood(foods : userFoods)
    func getFoodById(byIdentifier user_id: UUID) -> [userFoods]?
    
}

struct UserFoodsRepository : FoodRepository
{
    func createFood(foods: userFoods) {
        
        let user_foods = UserFoods(context: PersistentStorage.shared.context)
        user_foods.food_date = foods.food_date
        user_foods.food_name = foods.food_name
        user_foods.food_type = foods.food_type
        user_foods.serving = foods.serving
        user_foods.meal_type = foods.meal_type
        user_foods.user_id = foods.user_id
        user_foods.calorie_in = foods.calorie_in
        
        
        PersistentStorage.shared.saveContext()
    }
    
    func getFoodById(byIdentifier user_id: UUID) -> [userFoods]? {
        let result = getUserFoods(byIdentifier: user_id)
        var foods: [userFoods]=[]
        
        result?.forEach({ (userFood) in
            foods.append(userFood.convertToFood())
        })
        return foods
       
    }
    
    func getFoodByIdAndDate(user_id: UUID, dateString: String) -> [userFoods]? {
        let result = getUserFoods(byIdentifier: user_id)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" // Use the appropriate date format
        if let date = dateFormatter.date(from: dateString) {
            var foods: [userFoods] = []
            result?.forEach { (userFood) in
                // Check if the food date matches the provided date
                if let foodDate = userFood.food_date, Calendar.current.isDate(foodDate, inSameDayAs: date) {
                    foods.append(userFood.convertToFood())
                }
            }
            return foods
        }

        return nil // Return nil if date conversion fails
    }

    
    private func getUserFoods(byIdentifier id: UUID) -> [UserFoods]?
    {
        let fetchRequest = NSFetchRequest<UserFoods>(entityName: "UserFoods")
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
