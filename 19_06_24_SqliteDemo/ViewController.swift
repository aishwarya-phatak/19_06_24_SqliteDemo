//
//  ViewController.swift
//  19_06_24_SqliteDemo
//
//  Created by Vishal Jagtap on 19/08/24.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        var db = DBHelper.shared
//        db.insertEmployeeDataIntoTable(empId: 106, empName: "Jaidepp")
//        db.insertEmployeeDataIntoTable(empId: 107, empName: "Shreya")
//        db.insertEmployeeDataIntoTable(empId: 108, empName: "Saqib")
//        db.insertEmployeeDataIntoTable(empId: 109, empName: "Bhakti")
//        db.insertEmployeeDataIntoTable(empId: 110, empName: "Megha")
//        
        for eachEmployee in db.retriveEmployeeRecords(){
            print("\(eachEmployee.empId) -- \(eachEmployee.empName)")
        }
        
        db.deleteEmployeeDataFromTable(empId: 110)
        
        for eachEmployee in db.retriveEmployeeRecords(){
            print("\(eachEmployee.empId) -- \(eachEmployee.empName)")
        }
    }
}
