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
    var nickname: String
    var gender: String
    var birthday: String
    var phoneNumber: String
    
    init(uid:String, email: String, userName: String, nickName: String, gender: String, birthDay: String, phoneNumber: String) {
        self.uid = uid
        self.email = email
        self.name = userName
        self.nickname = nickName
        self.gender = gender
        self.birthday = birthDay
        self.phoneNumber = phoneNumber
        
    }
    
    func getUserDataDictionary() -> Dictionary<String, String> {
        return [
            "uid": self.uid,
            "email": self.email,
            "name": self.name,
            "nickname": self.nickname,
            "gender": self.gender,
            "birthday": self.birthday,
            "phone": self.phoneNumber
        ]
    }
}

