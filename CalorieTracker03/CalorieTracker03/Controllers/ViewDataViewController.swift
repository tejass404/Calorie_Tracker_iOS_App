//
//  ViewDataViewController.swift
//  CalorieTracker03
//
//  Created by LMD User on 10/12/23.
//  Copyright © 2023 mac. All rights reserved.
//

import UIKit

var selectedUserID : UUID?
var selectedUserName : String?


class ViewDataViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    @IBOutlet weak var viewDataTable: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    private let manager: UserDetailManager = UserDetailManager()
    private let FoodManager: UserFoodManager = UserFoodManager()
    private let ActivityManager: UserActivityManager = UserActivityManager()
    
    var viewDataArray: [(date: String, calorieIn: Float, calorieOut: Float)] = []

    var userFood = [userFoods]()
    var userActiviti = [userActivities]()
    var bmr: Float = 0.0
    var netCalorie: Float = 0.0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(viewDataArray.count)")
        return viewDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath) as! ViewDataTableViewCell
        let data = viewDataArray[indexPath.row]
        netCalorie = data.calorieIn - bmr - data.calorieOut
        
        cell.dateLabel.text = data.date
        cell.calorieInLabel.text = String(format: "%.1f", data.calorieIn)
        cell.calorieOutLabel.text = String(format: "%.1f", data.calorieOut)
        cell.bmrLabel.text = String(format: "%.1f", bmr)
        cell.netCalorieLabel.text = String(format: "%.1f", netCalorie)
        cell.viewButton.tag = indexPath.row
        cell.viewButton.addTarget(self, action: #selector(viewDataBtnAction) , for: .touchUpInside)

        return cell
        
    }
    
    @objc func viewDataBtnAction(sender : UIButton){
        let indexpath0 = IndexPath(row: sender.tag, section: 0)
        let data = viewDataArray[indexpath0.row]
        selectedCalorieIn = data.calorieIn
        selectedCalorieOut = data.calorieOut
        selectedNetCalorie = netCalorie
        selectedBMR = bmr
        selectedDate = data.date
        selectedName = selectedUserName
        userID = selectedUserID
        let destinationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewDetailsViewController") as! ViewDetailsViewController
        self.navigationController?.pushViewController(destinationViewController, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDataTable.dataSource = self
        viewDataTable.rowHeight = 150
        
        bmr = manager.getUserBMR(forUserId: selectedUserID!)!
        print(">>>>>>>>>>>> \(bmr)")
        
        nameLabel.text = selectedUserName
        viewDataTable.reloadData()
        userFood = FoodManager.getFoodById(byIdentifier: selectedUserID!)!
        userActiviti = ActivityManager.getActivityById(byIdentifier: selectedUserID!)!
        
        var consolidatedData: [String: (calorieIn: Float, calorieOut: Float)] = [:]

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        for food in userFood {
            if let date = food.food_date {
                let dateString = dateFormatter.string(from: date)
                let caloriesIn = food.calorie_in

                if let existingData = consolidatedData[dateString] {
                    consolidatedData[dateString] = (existingData.calorieIn + caloriesIn, existingData.calorieOut)
                } else {
                    consolidatedData[dateString] = (caloriesIn, 0)
                }
            }
        }

        for activity in userActiviti {
            if let date = activity.activity_date {
                let dateString = dateFormatter.string(from: date)
                let caloriesOut = activity.calorie_out

                if let existingData = consolidatedData[dateString] {
                    consolidatedData[dateString] = (existingData.calorieIn, existingData.calorieOut + caloriesOut)
                } else {
                    consolidatedData[dateString] = (0, caloriesOut)
                }
            }
        }
        
        for (date, data) in consolidatedData {
                    viewDataArray.append((date: date, calorieIn: data.calorieIn, calorieOut: data.calorieOut))
                }

        print(viewDataArray)

        
        
    }
   

}
