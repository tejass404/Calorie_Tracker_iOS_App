//
//  ActivityDataModel.swift
//  CalorieTracker03
//
//  Created by mac on 10/10/23.
//  Copyright © 2023 mac. All rights reserved.
//

import Foundation


struct ActivityDataModel: Decodable	{
    var ACTIVITY: String?
    var SPECIFICMOTION: String?
    var METs: Float
}
