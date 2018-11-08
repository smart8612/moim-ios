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

    
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var birthdayLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let fireBaseAuth = Auth.auth()
        let currentUser = fireBaseAuth.currentUser
        
        ref = Database.database().reference()
        self.ref.child("users").child(currentUser!.uid).child("userInformation").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            
            self.emailLabel.text = currentUser?.email
            self.nameLabel.text = value?["name"] as? String ?? ""
            self.birthdayLabel.text = value?["birthday"] as? String ?? ""
            self.phoneLabel.text = value?["phone"] as? String ?? ""
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
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
