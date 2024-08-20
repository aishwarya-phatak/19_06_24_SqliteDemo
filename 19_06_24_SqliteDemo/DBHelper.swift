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
        createTableEmployee()
    }
    
    private func createDatabase()->OpaquePointer?{
       var fileURL = try! FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false).appendingPathComponent(dbPath)
        
        if sqlite3_open(fileURL.path(), &db) == SQLITE_OK{
            print("database created successfully \(fileURL.path)")
            return db!
        }else{
            print("database creation failed")
            return nil
        }
    }
    
    private func createTableEmployee(){
        let createQueryString = "CREATE TABLE IF NOT EXISTS Employee(empId INTEGER, empName TEXT);"
        var createStatement : OpaquePointer?
        
        if sqlite3_prepare(db,
                           createQueryString,
                           -1,
                           &createStatement,
                           nil) == SQLITE_OK{
            print("Statement Preparation Successful")
            
            if sqlite3_step(createStatement) == SQLITE_DONE{
                print("Employee Table Creation is successful")
            }else{
                print("Employee Table Creation Failed")
            }
        }else{
            print("Statement preparation Failed")
        }
        sqlite3_finalize(createStatement)
    }
    
    func insertEmployeeDataIntoTable(empId : Int, empName : String){
        let insertQueryString = "INSERT INTO Employee(empId,empName) VALUES(?,?);"
        var insertStatement : OpaquePointer?
        
        if sqlite3_prepare(
            db,
            insertQueryString,
            -1,
            &insertStatement,
            nil) == SQLITE_OK{
            print("Insert Statement created succesfully")
            
            sqlite3_bind_int(insertStatement, 1, Int32(empId))
            sqlite3_bind_text(
                    insertStatement,
                    2,
                    (empName as NSString).utf8String,
                    -1,
                    nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE{
                print("Employee Record Insertion Succesaful")
            }else{
                print("Employee Record Insertion Failed")
            }
        }else{
            print("Insert Statement Creation Failed")
        }
        
        sqlite3_finalize(insertStatement)
    }

    func deleteEmployeeDataFromTable(empId : Int){
        let deleteQueryString = "DELETE FROM Employee where empId = ?;"
        var deleteStatement : OpaquePointer?
        
        if sqlite3_prepare(db,
                           deleteQueryString,
                           -1,
                           &deleteStatement,
                           nil) == SQLITE_OK{
            print("Delete Statement Prepared Successfully")
            
            sqlite3_bind_int(deleteStatement, 1, Int32(empId))
            
            if sqlite3_step(deleteStatement) == SQLITE_DONE{
                print("Employee Record Deleted Successfully")
            }else{
                print("Employee Record Deletion Failed")
            }
        }else{
            print("Delete Statement Preparation Failed")
        }
        sqlite3_finalize(deleteStatement)
    }
    

    func retriveEmployeeRecords()->[Employee]{
        var employees : [Employee] = []
        let retriveEmployeeQueryString = "SELECT * FROM Employee;"
        var retriveStatement : OpaquePointer?
        
        if sqlite3_prepare(db, 
                           retriveEmployeeQueryString,
                           -1,
                           &retriveStatement,
                           nil) == SQLITE_OK{
            print("Retrive Statement Prepaprtion Successful")

            while sqlite3_step(retriveStatement) == SQLITE_ROW{
               let extractedEmpId =  sqlite3_column_int(retriveStatement, 0)
                let extractedEmpName = String(describing: String(cString: sqlite3_column_text(retriveStatement, 1)))
                
                employees.append(Employee(empId: Int(extractedEmpId), empName: extractedEmpName))
            }
        }else{
            print("Retrive Statement Prepaprtion Failed")
        }
        sqlite3_finalize(retriveStatement)
        return employees
    }
}
