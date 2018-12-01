//
//  EventMapViewController.swift
//  moim
//
//  Created by JeongTaek Han on 01/12/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class EventMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var eventMap: MKMapView!
    var locationManager: CLLocationManager!
    
    var initialLocation: CLLocation!
    var searchRadius: CLLocationDistance!
    
    var events = [Event]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.intializeMapView()
        eventDataInitializer()
    }
    
    func addPinToMapView() {
        for event in self.events {
            let annotation = MKPointAnnotation()
            annotation.coordinate = event.coordinate
            annotation.title = event.title
            annotation.subtitle = event.text
            
            eventMap.addAnnotation(annotation)
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
            self.addPinToMapView()
            
        })
    }
    
    private func eventArrayReset() {
        events.removeAll()
    }
    
    private func intializeMapView() {
        setUpLocationManager()
        mapViewSetUp()
        getCurrentLocation()
        setRegionToMapView()
       
    }
    
    private func setRegionToMapView() {
        let coordinateRegion = MKCoordinateRegion.init(
            center: initialLocation.coordinate,
            latitudinalMeters: searchRadius * 2.0,
            longitudinalMeters: searchRadius * 2.0
        )
        
        eventMap.setRegion(coordinateRegion, animated: true)
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
    
    private func mapViewSetUp() {
        eventMap.showsUserLocation = true
        eventMap.showsBuildings = true
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
