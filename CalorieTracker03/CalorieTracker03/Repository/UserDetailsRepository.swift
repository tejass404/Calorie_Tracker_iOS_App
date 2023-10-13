//
//  UserDetailsRepository.swift
//  CalorieTracker03
//
//  Created by mac on 05/10/23.
//  Copyright © 2023 mac. All rights reserved.
//

import Foundation
import CoreData

protocol UserRepository {
    
    func create(user : UserDetails)
    func getAll() -> [UserDetails]?
    func get(byIdentifier id : UUID) -> UserDetails?
    func delete(user: UserDetails) -> Bool
}

struct UserDataRepository : UserRepository
{
    func create(user: UserDetails) {
        
        let userDetail = CDUserDetails(context: PersistentStorage.shared.context)
        userDetail.age = user.age
        userDetail.bmr = user.bmr
        userDetail.gender = user.gender
        userDetail.height = user.height
        userDetail.weight = user.weight
        userDetail.name = user.name
        userDetail.id = user.id
        
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [UserDetails]? {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: CDUserDetails.self)
        
        var users: [UserDetails]=[]
        
        result?.forEach({ (userDetail) in
            users.append(userDetail.convertToUser())
        })
        return users
    }
    
    func get(byIdentifier id: UUID) -> UserDetails? {
        let result = getCDUserDetails(byIdentifier: id)
        guard result != nil else {return nil}
        return result!.convertToUser()
    }
    
    func delete(user: UserDetails)-> Bool {
        let userDetail = getCDUserDetails(byIdentifier: user.id!)
        guard userDetail != nil else{return false}
        
        PersistentStorage.shared.context.delete(userDetail!)
        return true
    }
    
    func getWeight(forUserId id: UUID) -> Float? {
        
        let user = getCDUserDetails(byIdentifier: id)
        
        return user?.weight
        
    }
    
    func getBMR(forUserId id: UUID) -> Float? {
        
        let user = getCDUserDetails(byIdentifier: id)
        
        return user?.bmr
        
    }
    
    private func getCDUserDetails(byIdentifier id: UUID) -> CDUserDetails?
    {
        let fetchRequest = NSFetchRequest<CDUserDetails>(entityName: "CDUserDetails")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        do{
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else {return nil}
            return result
        }catch let error{
            debugPrint(error)
            return nil
        }
    }
    
    
    
}
