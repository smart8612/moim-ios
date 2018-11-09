//
//  UserService.swift
//  moim
//
//  Created by JeongTaek Han on 09/11/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import Foundation
import Firebase


class UserService {
    
    static var currentUserProfile: UserProfile?
    
    static func observeUserProfile(_ uid:String, completion: @escaping ((_ userProfile: UserProfile?)->())) {
        
        let userRef = Database.database().reference().child(uid)
        
        userRef.observe(.value, with: { snapshot in
            var userProfile:UserProfile?
            
            if let dict = snapshot.value as? [String:Any],
                let username = dict["name"] as? String,
                let email = dict["email"] as? String {
                userProfile = UserProfile(uid: uid, email: email, username: username)
                
            }
            
            completion(userProfile)
        })
    }
    
}
