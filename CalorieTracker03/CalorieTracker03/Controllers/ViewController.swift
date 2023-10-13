//
//  ViewController.swift
//  initialApp
//
//  Created by mac on 04/10/18.
//  Copyright © 2018 mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var genderSC: UISegmentedControl!
    private let manager: UserDetailManager = UserDetailManager()
    private var bmr:Float = 0.0
    private var gender:String = ""
    private var age:Int16 = 0
    private var height:Int16 = 0
    private var weight:Float = 0.0
    private var name:String = ""
    private var selectedGender:String = ""

    
    
    @IBAction func genderSCAction(_ sender: UISegmentedControl) {
        
        switch genderSC.selectedSegmentIndex {
        case 0:
            selectedGender="male"
        case 1:
            selectedGender="female"
        default:
            break
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ageTextField.delegate = self
        heightTextField.delegate = self
        weightTextField.delegate = self
        nameTextField.delegate = self
   		
        
    }
    
    func calculateMaleBMR(weight: Float, height: Float, age: Int16) -> Float {
        return (66.4730 + (13.7516 * weight) + (5.0033 * height) - (6.7550 * Float(age)))
    }
    
    func calculateFemaleBMR(weight: Float, height: Float, age: Int16) -> Float {
        return (655.0955 + (9.5634 * weight) + (1.8496 * height) - (4.6756 * Float(age)))
    }
    
    @IBAction func signUpBtn(_ sender: UIButton) {
    
        age = Int16(ageTextField.text ?? "")!
        height = Int16(heightTextField.text ?? "")!
        weight = Float(weightTextField.text ?? "")!
        name = nameTextField.text ?? ""
        if selectedGender.lowercased() == "male" {
            bmr = calculateMaleBMR(weight: weight, height: Float(height), age: age)
        } else if selectedGender.lowercased() == "female" {
            bmr = calculateFemaleBMR(weight: weight, height: Float(height), age: age)
        }else{
            bmr = calculateMaleBMR(weight: weight, height: Float(height), age: age)
        }
        
        
        let user = UserDetails(age: age,bmr: bmr,gender: gender,height: height, id: UUID(), name: name, weight: weight)
        
                manager.createUser(user: user)
                debugPrint("user Created")
        let userListVC = self.storyboard?.instantiateViewController(withIdentifier: "UserListViewController") as! UserListViewController
        self.navigationController?.pushViewController(userListVC, animated: true)
        
    }

    @IBAction func userListBtn(_ sender: UIButton) {
        print("Navigation Controller: \(String(describing: self.navigationController))")
        let destinationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserListViewController") as! UserListViewController
        self.navigationController?.pushViewController(destinationViewController, animated: true)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        nameTextField.resignFirstResponder()
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
        ageTextField.resignFirstResponder()
    }
    
}

extension ViewController : UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

