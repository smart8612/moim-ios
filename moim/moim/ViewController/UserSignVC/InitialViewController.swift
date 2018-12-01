//
//  InitialViewController.swift
//  moim
//
//  Created by JeongTaek Han on 27/09/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import UIKit
import Firebase
import SPPermission

class InitialViewController: UIViewController {
    
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        checkPermission()
        userSessionObserver()
    }
    
    func checkPermission() {
        let isAvailableCamera = SPPermission.isAllow(.camera)
        let isAvailableLocation = SPPermission.isAllow(.locationWhenInUse)
        
        if !(isAvailableCamera && isAvailableLocation) {
            SPPermission.Dialog.request(with: [.camera, .locationWhenInUse], on: self)
        }
    }
    
    func userSessionObserver() {
        let FireBaseAuth = Auth.auth()
        
        if FireBaseAuth.currentUser != nil {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
            
            self.window?.rootViewController = controller
            self.present(controller, animated: false, completion: nil)
        }
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
