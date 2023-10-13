//
//  UserListViewController.swift
//  CalorieTracker03
//
//  Created by mac on 06/10/23.
//  Copyright © 2023 mac. All rights reserved.
//

import UIKit
import CoreData

class UserListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var userTable: UITableView!
    let context = PersistentStorage.shared.context
    private let manager: UserDetailManager = UserDetailManager()
    var users: [UserDetails] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
        
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
    let user = users[indexPath.row]
    cell.name.text = user.name
    cell.ageField.text = String(user.age)
    cell.heightField.text = String(user.height)
    cell.weightField.text = String(user.weight)
    cell.bmrField.text = String(format: "%.2f", user.bmr)
    cell.addDataBtn.tag = indexPath.row
    cell.addDataBtn.addTarget(self, action: #selector(addDataBtnAction) , for: .touchUpInside)
    cell.viewDataBtn.tag = indexPath.row
    cell.viewDataBtn.addTarget(self, action: #selector(viewDataBtnAction) , for: .touchUpInside)
    cell.backgroundColor = UIColor.white
    return cell
    }
    
    @objc func viewDataBtnAction(sender : UIButton){
        let indexpath0 = IndexPath(row: sender.tag, section: 0)
        let user = users[indexpath0.row]
        selectedUserID = user.id
        selectedUserName = user.name
        let destinationViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewDataViewController") as! ViewDataViewController
        self.navigationController?.pushViewController(destinationViewController, animated: true)
        
    }
    
    @objc func addDataBtnAction(sender : UIButton){
        let indexpath0 = IndexPath(row: sender.tag, section: 0)
        let user = users[indexpath0.row]
        selectedID = user.id
        selectedIDActivity = user.id
        let destinationViewController = self.storyboard?.instantiateViewController(withIdentifier: "tabBarController") as! tabBarController
        self.navigationController?.pushViewController(destinationViewController, animated: true)
        print("Navigation Controller: \(String(describing: self.navigationController))")
        print("Action fuhnction\(String(describing: selectedID))")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTable.rowHeight = 150
        
        users = manager.getAllUsers()!
        users.reverse()
        userTable.reloadData()
        debugPrint(users)
	
    }
   

}
