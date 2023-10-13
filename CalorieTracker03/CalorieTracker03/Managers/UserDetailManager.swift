//
//  UserDetailManager.swift
//  CalorieTracker03
//
//  Created by mac on 06/10/23.
//  Copyright © 2023 mac. All rights reserved.
//

import Foundation
import CoreData

struct UserDetailManager
{
    private let  userDetailsRepo = UserDataRepository()
    
    func createUser(user : UserDetails){
        userDetailsRepo.create(user: user)
    }
    
    func getAllUsers() -> [UserDetails]?{
        return userDetailsRepo.getAll()
    }
    func get(byIdentifier id : UUID) -> UserDetails?{
        return userDetailsRepo.get(byIdentifier: id)
    }
    func deleteUser(user: UserDetails) -> Bool{
        return userDetailsRepo.delete(user:user)
    }
    func getUserWeight(forUserId id: UUID) -> Float? {
        return userDetailsRepo.getWeight(forUserId: id)
    }
    func getUserBMR(forUserId id: UUID) -> Float? {
        return userDetailsRepo.getBMR(forUserId: id)
    }
}
