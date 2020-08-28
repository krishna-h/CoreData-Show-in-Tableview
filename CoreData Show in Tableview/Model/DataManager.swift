//
//  DataManager.swift
//  CoreData Show in Tableview
//
//  Created by Mac on 27/08/20.
//  Copyright © 2020 Gunde Ramakrishna Goud. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DataManager {
    static var instance = DataManager()
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    // CREATING SAVE THE USER DETAILS FUNCTION
    func saveData(receivedData:NSDictionary,profileImage: Data)  {
        let students = NSEntityDescription.insertNewObject(forEntityName: "Colleges", into: context!) as! Colleges
        students.setValue("\(receivedData["name"]!)", forKey: "name")
        students.setValue("\(receivedData["email"]!)", forKey: "email")
        students.setValue("\(receivedData["mobileNo"]!)", forKey: "mobileNo")
        students.setValue("\(receivedData["address"]!)", forKey: "address")
        students.setValue("\(receivedData["collegeName"]!)", forKey: "collegeName")
        students.setValue("\(receivedData["univercity"]!)", forKey: "univercity")
        students.setValue(profileImage, forKey: "profileImage")
        do {
            try context?.save()
            print("Sucessfully Data is saved")
        } catch  {
            print("Data is not save")
        }
    }
    // FETCH THE USER DETAILS FUNCTION
    func fetchData() -> [Colleges]    {
        var arrStudent = [Colleges]()
        
        var fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Colleges")
        do {
            arrStudent = try context?.fetch(fetchRequest) as! [Colleges]
            for i in 0..<arrStudent.count
            {
                var mo = arrStudent[i]
                print("ProfileImage is \(mo.value(forKey: "profileImage")!)")
            }
        } catch let err {
            print("Error in College fetch -: \(err.localizedDescription)")
        }
        return arrStudent
    }
    //DETELTE THE USER DATA IN TABLE FUNCTION
    func deleteData(index: Int) ->[Colleges]
    {
        var collegeData = self.fetchData()
        context?.delete(collegeData[index])
        collegeData.remove(at: index)
        do{
            try context?.save()
        }catch let err {
            print("delete college data :- \(err.localizedDescription)")
        }
        return collegeData
    }
    //UPDATING USER DATA IN TABLE FUNCTION
    func updateData(receivedData:NSDictionary,profileImage: Data, index: Int)  {
    
        var college = self.fetchData()
        college[index].setValue("\(receivedData["name"]!)", forKey: "name")
        college[index].setValue("\(receivedData["email"]!)", forKey: "email")
        college[index].setValue("\(receivedData["mobileNo"]!)", forKey: "mobileNo")
        college[index].setValue("\(receivedData["address"]!)", forKey: "address")
        college[index].setValue("\(receivedData["collegeName"]!)", forKey: "collegeName")
        college[index].setValue("\(receivedData["univercity"]!)", forKey: "univercity")
        college[index].setValue(profileImage, forKey: "profileImage")
        do {
            try context?.save()
            print("Sucessfully Updated ")
        } catch  {
            print("Data is not Updated")
        }
    }
    
}
