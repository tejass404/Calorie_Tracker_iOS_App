//
//  AddActivityViewController.swift
//  CalorieTracker03
//
//  Created by mac on 10/10/23.
//  Copyright © 2023 mac. All rights reserved.
//

// AddActivityViewController.swift

import UIKit
import CoreData

var selectedIDActivity : UUID?


class AddActivityViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    @IBOutlet weak var activityTypeTextField: UITextField!
    @IBOutlet weak var durationTextField: UITextField!
    @IBOutlet weak var activityTableView: UITableView!
    
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var activitySearchTextField: UITextField!
    @IBOutlet weak var metValueTextField: UITextField!
    
    private let manager: UserDetailManager = UserDetailManager()
    private let ActivityManager: UserActivityManager = UserActivityManager()

    
    let datePicker = UIDatePicker()
    let toolbar = UIToolbar()
    
    
    var activities = [ActivityDataModel]()
    var filteredActivities = [ActivityDataModel]()
    var activityName: String = ""
    var activityType: String = ""
    var METValue: Float = 0.0
    var userWeight: Float = 0.0
    var Duration: Float = 0.0
    var activityDate: Date?  = nil
    

    
    
    
    @IBAction func addActivityAction(_ sender: UIButton) {
        
        if let durationtext = durationTextField.text, !durationtext.isEmpty{
            Duration = Float(durationTextField.text!) ?? 0
            let durationInHrs = Duration / 60
            
            let calorieOut = METValue * userWeight * durationInHrs
            
            let activity = userActivities(activity_date: activityDate,activity_name: activityName, met_value: METValue,user_id: selectedIDActivity, calorie_out: calorieOut, activity_duration: durationInHrs, activity_type: activityType)
            print("DONEEE \(activityName)")
            ActivityManager.createActivity(activity: activity)
            
            durationTextField.text = ""
            activityTypeTextField.text = ""
            dateTextField.text = ""
            activitySearchTextField.text = ""
            metValueTextField.text = ""
            
            
        }else{
            let alert = UIAlertController(title: "Error", message: "Please Enter Duration", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                present(alert, animated: true)
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
      
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "en_US")
        datePicker.calendar = Calendar(identifier: .gregorian)
        datePicker.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 80)
        datePicker.contentHorizontalAlignment = .center
            datePicker.center = view.center

    
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: true)

        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = toolbar
        
        userWeight = manager.getUserWeight(forUserId: selectedIDActivity!)!
        print("\(userWeight)")
        
        
        
        activityTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        activityTableView.dataSource = self
        activityTableView.delegate = self
        
        activitySearchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        
        if let path = Bundle.main.path(forResource: "MET-values", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                activities = try decoder.decode([ActivityDataModel].self, from: data)
            } catch {
                print("Error reading or decoding JSON file:", error)
            }
        } else {
            print("JSON file not found in the bundle.")
        }
        activityTableView.isHidden = true
    }
    
    @objc func donePressed() {
      
      let formatter = DateFormatter()
        formatter.dateStyle = .medium
      dateTextField.text = formatter.string(from: datePicker.date)
        activityDate = datePicker.date
      view.endEditing(true)

    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
      dateTextField.resignFirstResponder()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        filteredActivities = activities.filter({ $0.SPECIFICMOTION?.contains(textField.text!) ?? false })
        activityTableView.reloadData()
        activityTableView.isHidden = false
        activityTypeTextField.isHidden = true
        metValueTextField.isHidden = true
        durationTextField.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredActivities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let activity = filteredActivities[indexPath.row]
        cell.textLabel?.text = activity.SPECIFICMOTION
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let activity = filteredActivities[indexPath.row]
    
        activityName = activity.SPECIFICMOTION!
        activityType = activity.ACTIVITY!
        METValue = activity.METs
        
        
        activitySearchTextField.text = activityName
        activityTypeTextField.text = activityType
        metValueTextField.text = String(METValue)

    
        
        activityTypeTextField.isUserInteractionEnabled = false
        metValueTextField.isUserInteractionEnabled = false
        
        tableView.isHidden = true
        activityTypeTextField.isHidden = false
        metValueTextField.isHidden = false
        durationTextField.isHidden = false
        activitySearchTextField.resignFirstResponder()
    }
    
}
