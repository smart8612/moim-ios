//
//  Post.swift
//  moim
//
//  Created by JeongTaek Han on 07/10/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import Foundation


class Post {
    var uid: String
    var postId: String
    var text: String
    var imageURL: String
    var name: String!
    
    init(uid: String, postId: String, text: String, url: String) {
        self.uid = uid
        self.postId = postId
        self.text = text
        self.imageURL = url
    }
    
    func getPostDataDictionary() -> Dictionary<String, String> {
        return [
            "uid": self.uid,
            "postId": self.postId,
            "text": self.text,
            "url": self.imageURL
        ]
    }
}
