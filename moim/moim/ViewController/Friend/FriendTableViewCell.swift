//
//  FriendTableViewCell.swift
//  moim
//
//  Created by JeongTaek Han on 28/10/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import UIKit
import Firebase

class FriendTableViewCell: UITableViewCell {
    
    @IBOutlet var friendProfileImage: UIImageView!
    @IBOutlet var friendNameLabel: UILabel!
    @IBOutlet var friendStatusLabel: UILabel!
    @IBOutlet var friendAddButton: UIButton!
    var uid: String!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    @IBAction func addButtonClicked(_ sender: UIButton) {
        let user = Auth.auth().currentUser?.uid
        let userRef = Database.database().reference().child("users/\(user!)/subscribe/\(self.uid!)")
        
        userRef.observeSingleEvent(of: .value, with: { snapshot in
            
            if snapshot.exists() {
                sender.setTitle("Add Friend", for: .normal)
                userRef.removeValue()
                
            } else {
                sender.setTitle("UnFollow", for: .normal)
                userRef.setValue(true)
            }
            
        })
    }
    
    func changeFollowStatus(uid: String) {
        let user = Auth.auth().currentUser?.uid
        let userRef = Database.database().reference().child("users/\(user!)/subscribe/\(uid)")
        
        userRef.observeSingleEvent(of: .value, with: { snapshot in
            
            if snapshot.exists() {
                self.friendAddButton.setTitle("UnFollow", for: .normal)
                
            } else {
                self.friendAddButton.setTitle("Add Friend", for: .normal)
                
            }
            
        })
    }
    
}
