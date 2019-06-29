//
//  API.swift
//  OnTheMap
//
//  Created by Deema  on 09/06/2019.
//  Copyright © 2019 Udacity. All rights reserved.
//
import Foundation
import UIKit

class API {
    //login
    static func login (username:String , password:String , completion: @escaping ( String,Error?)->()){
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody  = "{\"udacity\": {\"username\": \"\(username)\", \"password\": \"\(password)\"}}".data(using: .utf8)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion("",error)
            }
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            if let statusCode = statusCode{
                if statusCode < 200  || statusCode > 300 {
                    completion("",nil)
                }
                else{
                    let range = Range(5..<data!.count)
                    let newData = data?.subdata(in: range)
                    let decoder = JSONDecoder()
                    do{
                        let studentArray = try decoder.decode(Users.self, from: newData!)
                        let studentKey = studentArray.account?.key  as! String
                        completion(studentKey,nil)
                    }catch let error{
                        print (error)
                    }
                }
            }
            else{
                completion("No response",nil)
            }
            
            
            
            
        }
        task.resume()
        
        
    }
    
    //login finished
    
    //logout
   static func logOutAPI(completion: @escaping (Error?) -> ()){
        var request = URLRequest(url: URL(string: "https://onthemap-api.udacity.com/v1/session")!)
        request.httpMethod = "DELETE"
        var xsrfCookie: HTTPCookie? = nil
        let sharedCookieStorage = HTTPCookieStorage.shared
        for cookie in sharedCookieStorage.cookies! {
            if cookie.name == "XSRF-TOKEN" { xsrfCookie = cookie }
        }
        if let xsrfCookie = xsrfCookie {
            request.setValue(xsrfCookie.value, forHTTPHeaderField: "X-XSRF-TOKEN")
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(error)
            }
            
            completion(nil)
        }
        task.resume()
    }
    //logout finished
    
    
    
    static func getLocations (completion: @escaping (Bool, Error?) -> ()) {
        var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation?limit=100&order=-updatedAt")!)
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error...
                completion(false,error)
            }
            do{
                let decoder = JSONDecoder()
                let studentArray = try decoder.decode(StudentsLocations.self, from: data!)
                DispatchQueue.main.async {
                    StudentInfo.udacityStudent = studentArray
                    completion(true,error)
                }
            }catch let error {
                print (error)
            }
        }
        task.resume()
        
    }
    
    static func postLocation(mapString : String ,mediaURL : String ,latitude : Double ,longitude: Double,completion: @escaping (Error?) -> ()){
        var request = URLRequest(url: URL(string: "https://parse.udacity.com/parse/classes/StudentLocation")!)
        request.httpMethod = "POST"
        request.addValue("QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr", forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue("QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY", forHTTPHeaderField: "X-Parse-REST-API-Key")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = "{\"uniqueKey\": \"\(StudentInfo.userKey)\", \"firstName\": \"Deema\", \"lastName\": \"Almutairi\",\"mapString\": \"\(mapString)\", \"mediaURL\": \"\(mediaURL)\",\"latitude\": \(latitude), \"longitude\": \(longitude)}".data(using: .utf8)
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(error)
                return
            }
            print(String(data: data!, encoding: .utf8)!)
            completion(nil)
        }
        task.resume()
    }
    
    
    
    
    
}
