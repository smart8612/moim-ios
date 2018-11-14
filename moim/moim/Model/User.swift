//
//  User.swift
//  moim
//
//  Created by JeongTaek Han on 07/10/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import Foundation


class User {
    var uid: String
    var email: String
    var name: String
    
    init(uid:String, email: String, username: String) {
        self.uid = uid
        self.email = email
        self.name = username
        
    }
    
    func getUserDataDictionary() -> Dictionary<String, String> {
        return [
            "uid": self.uid,
            "email": self.email,
            "name": self.name
        ]
    }
}

