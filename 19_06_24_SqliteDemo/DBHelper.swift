//
//  DBHelper.swift
//  19_06_24_SqliteDemo
//
//  Created by Vishal Jagtap on 19/08/24.
//

import Foundation
import SQLite3

class DBHelper{
    var dbPath = "mydatabase.sqlite"
    var db : OpaquePointer?
    static var shared = DBHelper()
    
    private init(){
        db = createDatabase()
    }
    
    private func createDatabase()->OpaquePointer?{
       var fileURL = try! FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false).appendingPathComponent(dbPath)
        
        if sqlite3_open(fileURL.path(), &db) == SQLITE_OK{
            print("database created successfully")
            return db!
        }else{
            print("database creation failed")
            return nil
        }
    }
    
//    func createTableEmployee(){
//        
//    }
//    
//    func insertEmployeeDataIntoTable(){
//        
//    }
//    
//    func deleteEmployeeDataFromTable(){
//        
//    }
}
