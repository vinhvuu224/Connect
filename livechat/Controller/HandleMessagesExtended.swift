//
//  NewMessageController.swift
//  livechat
//
//  Created by Vinh Vu on 10/8/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit
import Firebase

class HandleMessagesExtended: UITableViewController {
    
    let userCellID = "userCellID"
    
    var users = [UserDatabase]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleControl))
        
        tableView.register(UsersCell.self, forCellReuseIdentifier: userCellID)
        
        grabUser()
    }
    
    func grabUser() {
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let user = UserDatabase(dictionary: dictionary)
                user.uniqueID = snapshot.key
                
                
                self.users.append(user)
                
               
                DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                })
                
            }
            
        }, withCancel: nil)
    }
    
    @objc func handleControl() {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userCellID, for: indexPath) as! UsersCell
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.username
        cell.detailTextLabel?.text = user.userEmail
        
        if let usersProfilePictureUrl = user.usersProfilePicture {
            cell.profileImageView.loadImageUsingCacheWithUrlString(usersProfilePictureUrl)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    var messagesController: HandleMessages?
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss(animated: true) {
            print("Dismiss completed")
            let user = self.users[indexPath.row]
            self.messagesController?.showChatControllerForUser(user)
        }
    }
    
}








