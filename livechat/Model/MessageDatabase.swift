//
//  Message.swift
//  livechat
//
//  Created by Vinh Vu on 10/8/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class MessageDatabase: NSObject {
    
    var senderID: String?
    var message: String?
    var timeSent: NSNumber?
    var receiverID: String?
    
    init(dictionary: [String: Any]) {
        self.senderID = dictionary["fromId"] as? String
        self.message = dictionary["text"] as? String
        self.receiverID = dictionary["toId"] as? String
        self.timeSent = dictionary["timestamp"] as? NSNumber
    }
    
}
