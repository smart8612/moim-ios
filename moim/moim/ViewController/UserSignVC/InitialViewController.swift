//
//  InitialViewController.swift
//  moim
//
//  Created by JeongTaek Han on 27/09/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import UIKit
import Firebase

class InitialViewController: UIViewController {
    
    var window: UIWindow?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        userSessionObserver()
    }
    
    func userSessionObserver() {
        let authListener = Auth.auth().addStateDidChangeListener { auth, user in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)

            if user != nil {
                //
                let controller = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
                self.window?.rootViewController = controller
                self.present(controller, animated: false, completion: nil)
            }
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
