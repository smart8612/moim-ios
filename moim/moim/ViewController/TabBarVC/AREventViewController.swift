//
//  SecondViewController.swift
//  moim
//
//  Created by JeongTaek Han on 19/09/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import UIKit
import ARCL
import ARKit
import SceneKit
import CoreLocation
import GLTFSceneKit

class AREventViewController: UIViewController {
    
//    var sceneLocationView = SceneLocationView()
    @IBOutlet weak var AREventSceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // Set the view's delegate
        AREventSceneView.delegate = self as? ARSCNViewDelegate
        
        // Show statistics such as fps and timing information
        AREventSceneView.showsStatistics = true
        
        // Create a new scene
//        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        var scene: SCNScene
        do {
            let sceneSource = try GLTFSceneSource(named: "art.scnassets/ar-modeling/Marker.gltf")
            scene = try sceneSource.scene()
        } catch {
            print("\(error.localizedDescription)")
            return
        }
        
        // Set the scene to the view
        AREventSceneView.scene = scene
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the AREventViewSession
        AREventSceneView.session.run(configuration)
        
//        sceneLocationView.run()
//        view.addSubview(sceneLocationView)
//
//        let coordinate = CLLocationCoordinate2D(latitude: 37.5513, longitude: 126.9889)
//        let location = CLLocation(coordinate: coordinate, altitude: 25)
//        let image = UIImage(named: "like")!
//        let annotationNode = LocationAnnotationNode(location: location, image: image)
//
//        sceneLocationView.addLocationNodeWithConfirmedLocation(locationNode: annotationNode)
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        sceneLocationView.frame = view.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        AREventSceneView.session.pause()
//        sceneLocationView.pause()
    }
    
}

