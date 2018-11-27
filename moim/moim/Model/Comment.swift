//
//  Comment.swift
//  moim
//
//  Created by JeongTaek Han on 27/11/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import Foundation

class Comment {
    var uid: String
    var text: String
    var timeStamp: Int
    
    init(uid: String, text: String, timeStamp: Int) {
        self.uid = uid
        self.text = text
        self.timeStamp = timeStamp
    }
    
}
