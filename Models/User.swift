//
//  User.swift
//  heyApp
//
//  Created by Admin on 11/05/2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit


class User: NSObject {
    var id: String?
    var name: String?
    var email: String?
    var profileImageUrl: String?
    init(dictionary: [String: AnyObject]) {
        self.id = dictionary["id"] as? String
        self.name = dictionary["name"] as? String
        self.email = dictionary["email"] as? String
        self.profileImageUrl = dictionary["profileImageUrl"] as? String
    }
}



/*
 class User: NSObject {
 var id:String?
 var name:String?
 var email:String?
 var profileImage:String?
 
 }
 */

