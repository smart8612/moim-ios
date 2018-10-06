//
//  SecondViewController.swift
//  moim
//
//  Created by JeongTaek Han on 19/09/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class AREventViewController: UIViewController {
    
    @IBOutlet var AREventSceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Set the view's delegate
        AREventSceneView.delegate = self as? ARSCNViewDelegate
        
        // Show statistics such as fps and timing information
        AREventSceneView.showsStatistics = true
        
        // Create a new scene
        let scene = SCNScene(named: "art.scnassets/ship.scn")!
        
        // Set the scene to the view
        AREventSceneView.scene = scene
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the AREventViewSession
        AREventSceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        AREventSceneView.session.pause()
    }
    
}

