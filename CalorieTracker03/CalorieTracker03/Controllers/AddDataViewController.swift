//
//  AddDataViewController.swift
//  CalorieTracker03
//
//  Created by mac on 09/10/23.
//  Copyright © 2023 mac. All rights reserved.
//

import UIKit

var selectedID : UUID?

class AddDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let datePicker = UIDatePicker()
    let toolbar = UIToolbar()

    @IBOutlet weak var foodGroupTextField: UITextField!
    @IBOutlet weak var mealTypeLabel: UILabel!
    @IBOutlet weak var mealTypeSC: UISegmentedControl!
    @IBOutlet weak var servingTextField: UITextField!
    @IBOutlet weak var foodTableView: UITableView!
    @IBOutlet weak var foodNameTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    var foods = [FoodDataModel]()
    var filteredFoods = [FoodDataModel]()
    
    private let FoodManager: UserFoodManager = UserFoodManager()

    
    var foodDate: Date?  = nil
    var calorieIn: Float = 0.0
    var foodCalories: Float = 0.0
    var foodName: String = ""
    var foodGroup: String = ""

    //var serving: Int16 = 0


    private var selectedMealType:String = ""

    @IBAction func mealtypeSegmentedControl(_ sender: UISegmentedControl) {
        
        switch mealTypeSC.selectedSegmentIndex {
        case 0:
            selectedMealType="Breakfast"
        case 1:
            selectedMealType="Lunch"
        case 2:
            selectedMealType="Dinner"
        default:
            selectedMealType = "Breakfast"
            
        }
    }
    
    
    @IBAction func addFoodAction(_ sender: UIButton) {
        
        if let serving = servingTextField.text, !serving.isEmpty{
            
            calorieIn = foodCalories * Float(serving)!
            print("\(calorieIn)")
            
            let food = userFoods(food_date: foodDate, food_name: foodName, food_type: foodGroup ,serving: Int16(serving)!, meal_type: selectedMealType , user_id: selectedID ,calorie_in: calorieIn)
            print("DONEEE, \(selectedMealType)")
            FoodManager.createFood(food: food)
            
            foodNameTextField.text = ""
            foodGroupTextField.text = ""
            servingTextField.text = ""
            dateTextField.text = ""
            
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
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
        
        
        print("Adddtaviewcontroller\(String(describing: selectedID))")
        
        foodTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        foodTableView.dataSource = self
        foodTableView.delegate = self
        
        foodNameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        if let path = Bundle.main.path(forResource: "food-calories", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                foods = try decoder.decode([FoodDataModel].self, from: data)
                let food = foods[0].name
                print(">>>>>>\(food)")
            } catch {
                print("Error reading or decoding JSON file:", error)
            }
        } else {
            print("JSON file not found in the bundle.")
        }
        
    }
    
    @objc func donePressed() {
      
      let formatter = DateFormatter()
        formatter.dateStyle = .medium
      dateTextField.text = formatter.string(from: datePicker.date)
        foodDate = datePicker.date
      view.endEditing(true)

    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
      dateTextField.resignFirstResponder()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        print("dcnejchec e cn")
        filteredFoods = foods.filter {
          $0.name?.localizedCaseInsensitiveContains(textField.text!) ?? false
        }
        foodTableView.reloadData()
        print("dcnejchec e cn \(filteredFoods.count)")
        foodTableView.isHidden = false
        mealTypeSC.isHidden = true
        servingTextField.isHidden = true
        foodGroupTextField.isHidden = true
        mealTypeLabel.isHidden = true
      
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("\(filteredFoods.count)")
        return filteredFoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        let food = filteredFoods[indexPath.row]
        cell.textLabel?.text = food.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let food = filteredFoods[indexPath.row]
        
        foodNameTextField.text = food.name
        foodName = food.name!
        foodGroup = food.foodGroup!
        foodGroupTextField.text = food.foodGroup
        foodCalories = food.Calories
        
        tableView.isHidden = true
        mealTypeSC.isHidden = false
        servingTextField.isHidden = false
        foodGroupTextField.isHidden = false
        mealTypeLabel.isHidden = false
    }
}
