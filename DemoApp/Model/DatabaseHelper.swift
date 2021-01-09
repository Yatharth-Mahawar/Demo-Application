//
//  DatabaseHelper.swift
//  DemoApp
//
//  Created by Yatharth Mahawar on 1/9/21.
//

import Foundation
import UIKit
import CoreData

class DataBaseHelper {
    static let shareInstance = DataBaseHelper()
    let context =  (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK:- SaveData
    
    func SaveData(dict:[String:String],imgData:Data){
        let profile = NSEntityDescription.insertNewObject(forEntityName: "Profile", into: context) as! Profile
        profile.img = imgData
        profile.firstName = dict["firstName"]
        profile.lastName = dict["lastName"]
        profile.dob = dict["dob"]
        profile.age = dict["age"]
        profile.gender = dict["gender"]
        profile.country = dict["country"]
        profile.state = dict["state"]
        profile.homeTown = dict["homeTown"]
        profile.phoneNumer = dict["phoneNumber"]
        profile.teleNumber = dict["teleNumber"]
        do {
            try context.save()
        }
        catch {
            print(error)
        }
        
    }
    
    //MARK:- Fetch Data
    
    func fetchData() -> [Profile] {
        var profile = [Profile]()
        let fetch = NSFetchRequest<NSManagedObject>(entityName: "Profile")
        do {
            profile = try context.fetch(fetch) as! [Profile]
        }
        catch {
            print(error)
        }
        
        return profile.reversed()
    }
    
    //MARK:- Delete Data
    
    func deleteData(index:Int) -> [Profile] {
        var profile = fetchData()
        context.delete(profile[index])
        profile.remove(at: index)
        do {
            try context.save()
        }
        catch {
            print(error)
        }
        return profile
    }
}
