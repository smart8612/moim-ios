//
//  SecondViewController.swift
//  moim
//
//  Created by JeongTaek Han on 19/09/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import UIKit
import Firebase

class AREventViewController: UIViewController {

    @IBOutlet weak var userInformation: UILabel!
    
    let fireBaseAuth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let user = fireBaseAuth.currentUser
        
        if user != nil {
            userInformation.text = user?.uid
        } else {
            userInformation.text = "do Login"
        }
    }


}

