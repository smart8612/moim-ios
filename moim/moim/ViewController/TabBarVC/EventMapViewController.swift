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

class EventMapViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var eventMap: MKMapView!
    var locationManager: CLLocationManager!
    
    var initialLocation: CLLocation!
    var searchRadius: CLLocationDistance!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.intializeMapView()
        
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
