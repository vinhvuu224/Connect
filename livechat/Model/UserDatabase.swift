//
//  User.swift
//  livechat
//
//  Created by Vinh Vu on 10/8/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class UserDatabase: NSObject {
    var uniqueID: String?
    var username: String?
    var userEmail: String?
    var usersProfilePicture: String?
    init(dictionary: [String: AnyObject]) {
        self.uniqueID = dictionary["id"] as? String
        self.username = dictionary["name"] as? String
        self.userEmail = dictionary["email"] as? String
        self.usersProfilePicture = dictionary["profileImageUrl"] as? String
    }
}
