//
//  StudentInfo.swift
//  OnTheMap
//
//  Created by Deema  on 09/06/2019.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation



struct StudentInfo : Codable {
    
    let createdAt : String?
    let firstName : String?
    let lastName : String?
    var latitude : Double?
    var longitude : Double?
    let mapString : String?
    let mediaURL : String?
    let objectId : String?
    let uniqueKey : String?
    let updatedAt : String?
    
    static var udacityStudent = StudentsLocations()
    static var userKey :String = "No Key"
    static var userDidAddLocation = false
}

