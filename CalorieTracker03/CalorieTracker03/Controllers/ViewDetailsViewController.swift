//
//  ViewDetailsViewController.swift
//  CalorieTracker03
//
//  Created by LMD User on 10/13/23.
//  Copyright © 2023 mac. All rights reserved.
//

import UIKit

var selectedCalorieIn: Float?
var selectedCalorieOut : Float?
var selectedNetCalorie : Float?
var selectedBMR : Float?
var selectedDate : String?
var selectedName : String?
var userID : UUID?

class ViewDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    @IBOutlet weak var activitytableview: UITableView!
    
    @IBOutlet weak var foodTableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var netCalorieLabel: UILabel!
    @IBOutlet weak var calorieOutLabel: UILabel!
    @IBOutlet weak var bmrLabel: UILabel!
    
    @IBOutlet weak var calorieInLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    private let FoodManager: UserFoodManager = UserFoodManager()
    private let ActivityManager: UserActivityManager = UserActivityManager()

    var userFood = [userFoods]()
    var userActivity_ = [userActivities]()
    override func viewDidLoad() {
        super.viewDidLoad()

        dateLabel.text = selectedDate
        netCalorieLabel.text = String(format: "%.1f",selectedNetCalorie!)
        calorieOutLabel.text = String(format: "%.1f",selectedCalorieOut!)
        calorieInLabel.text = String(format: "%.1f",selectedCalorieIn!)
        bmrLabel.text = String(format: "%.1f",selectedBMR!)
        nameLabel.text = selectedName
        
        userFood = FoodManager.getFoodByIdAndDate(user_id: userID!, dateString: selectedDate!)!
        print("\(userFood)")
        
        userActivity_ = ActivityManager.getActivityByIdAndDate(user_id: userID!, dateString: selectedDate!)!
        print("\(userActivity_)")
        
        foodTableView.dataSource = self
        foodTableView.rowHeight = 80
        
        activitytableview.dataSource = self
        activitytableview.rowHeight = 150
        
        foodTableView.reloadData()
        activitytableview.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView{
        case foodTableView:
            return userFood.count
        case activitytableview:
            return userActivity_.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var finalCell: UITableViewCell
        switch tableView{
        case foodTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellF", for: indexPath) as! FoodDataCell
            let userFood = userFood[indexPath.row]
            cell.calorieInLabel.text = String(format: "%.1f",userFood.calorie_in)
            cell.mealTypeLabel.text = userFood.meal_type
            cell.foodGroupLabel.text = userFood.food_type
            cell.servingLabel.text = String(userFood.serving)
            finalCell = cell
            return finalCell
            
        case activitytableview:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CellA", for: indexPath) as! ActivityDataCell
            let userActivity__ = userActivity_[indexPath.row]
            cell.descriptionLabel.text = userActivity__.activity_name
            cell.nameLabel.text = userActivity__.activity_type
            cell.metValueLabel.text = String(format: "%.1f",userActivity__.met_value)
            cell.durationLabel.text = String(format: "%.1f",userActivity__.activity_duration)
            cell.calorieOutLabel.text = String(format: "%.1f",userActivity__.calorie_out)
            finalCell = cell
            return finalCell
            
        default:
            return UITableViewCell()
        }
  
        
    }
    
}
