//
//  Users.swift
//  OnTheMap
//
//  Created by Deema  on 24/06/2019.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
struct Users : Codable{
    var account : Account?
}
struct Account : Codable {
    var key : String?
}
