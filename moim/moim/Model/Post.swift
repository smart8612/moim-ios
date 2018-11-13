//
//  Post.swift
//  moim
//
//  Created by JeongTaek Han on 07/10/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import Foundation


class Post {
    var name: String
    var text: String
    
    init(author: String, text: String) {
        self.name = author
        self.text = text
    }
    
    func getPostDataDictionary() -> Dictionary<String, String> {
        return [
            "name": self.name,
            "text": self.text
        ]
    }
}
