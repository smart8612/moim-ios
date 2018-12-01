//
//  SecondViewController.swift
//  moim
//
//  Created by JeongTaek Han on 19/09/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import UIKit
import ARCL
import CoreLocation
import GLTFSceneKit
import Firebase

class AREventViewController: UIViewController, CLLocationManagerDelegate {
    
    var sceneLocationView = SceneLocationView()
    var events = [Event]()
    
    var locationManager: CLLocationManager!
    
    var initialLocation: CLLocation!
    var searchRadius: CLLocationDistance!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.intializeARView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        eventDataInitializer()
        
        sceneLocationView.run()
        view.addSubview(sceneLocationView)
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sceneLocationView.frame = view.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneLocationView.pause()
    }
    
    func addPinToARView() {
        for event in self.events {
            let coordinate = event.coordinate
            guard let altitude = self.locationManager.location?.altitude else { return }
            let location = CLLocation(coordinate: coordinate, altitude: altitude)
            let image = UIImage(named: "pin")!
            let annotationNode = LocationAnnotationNode(location: location, image: image)
            
            sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
        
        }
    }
    
    private func eventDataInitializer() {
        let eventRef = Database.database().reference().child("events")
        
        eventArrayReset()
        
        eventRef.observe(.value, with: { snapshot in
            for child in snapshot.children.allObjects {
                let event = child as! DataSnapshot
                let eventDic = event.value as! Dictionary<String, Any>
                
                // Get Event Loaction
                guard let latitude = eventDic["latitude"] else { return }
                guard let longitude = eventDic["longitude"] else { return }
                
                let doubleLatitude = Double(latitude as! String)
                let doubleLongitude = Double(longitude as! String)
                
                let coordinate = CLLocationCoordinate2D(latitude: doubleLatitude!, longitude: doubleLongitude!)
                
                // Get Event Data
                guard let title = eventDic["title"] as? String else { return }
                guard let text = eventDic["text"] as? String else { return }
                guard let uid = eventDic["uid"] as? String else { return }
                
                // Generate New Event
                let tmpEvent = Event(eventId: event.key, coordinate: coordinate, title: title, text: text, url: String(), uid: uid)
                
                self.events.append(tmpEvent)
                
            }
            self.addPinToARView()
            
        })
    }
    
    private func eventArrayReset() {
        events.removeAll()
    }
    
    private func intializeARView() {
        setUpLocationManager()
        setUpARView()
        getCurrentLocation()
        
    }
    
    private func getCurrentLocation() {
        if let coor = locationManager.location?.coordinate {
            self.initialLocation = CLLocation(latitude: coor.latitude, longitude: coor.longitude)
            self.searchRadius = 500
            
        }
    }
    
    private func setUpLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
    }
    
    private func setUpARView() {
        sceneLocationView.run()
        sceneLocationView.showAxesNode = true
        view.addSubview(sceneLocationView)
    }

    
}

