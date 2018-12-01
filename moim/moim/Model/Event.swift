//
//  Event.swift
//  moim
//
//  Created by JeongTaek Han on 01/12/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import Foundation
import CoreLocation

class Event {
    // Event Unique Id
    var eventId: Int
    
    // Location Info
    var coordinate: CLLocationCoordinate2D
    
    // Event Info
    var title: String
    var text: String
    var url: String
    var uid: String
    
    
    init(eventId: Int, coordinate: CLLocationCoordinate2D, title: String, text: String, url: String, uid: String) {
        
        self.eventId = eventId
        self.coordinate = coordinate
        self.title = title
        self.text = text
        self.url = url
        self.uid = uid
        
    }
    
    func getEventDataDictionary() -> Dictionary<String, Any> {
        return [
            "eventId" : self.eventId,
            "coordinate" : self.coordinate,
            "title" : self.title,
            "text" : self.text,
            "url" : self.url,
            "uid" : self.uid
        ]
    }
    
}
