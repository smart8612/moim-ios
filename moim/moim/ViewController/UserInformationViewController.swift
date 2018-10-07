//
//  UserInformationViewController.swift
//  moim
//
//  Created by JeongTaek Han on 07/10/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import UIKit
import Firebase

class UserInformationViewController: UIViewController {

    @IBOutlet var userEmailLabel: UILabel!
    @IBOutlet var uidLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let fireBaseAuth = Auth.auth()
        let currentUser = fireBaseAuth.currentUser
        
        userEmailLabel.text = currentUser?.email
        uidLabel.text = currentUser?.uid
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
