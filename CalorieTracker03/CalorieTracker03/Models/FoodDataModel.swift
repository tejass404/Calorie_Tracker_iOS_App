//
//  FoodDataModel.swift
//  CalorieTracker03
//
//  Created by LMD User on 10/11/23.
//  Copyright © 2023 mac. All rights reserved.
//

import Foundation

struct FoodDataModel: Decodable    {
    var name: String?
    var foodGroup: String?
    var Calories: Float
}
