//
//  FirstViewController.swift
//  moim
//
//  Created by JeongTaek Han on 19/09/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import UIKit
import Firebase

class TimeLineViewController: UIViewController {
    
    @IBOutlet var textField: UITextField!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    

    @IBAction func closeButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        ref = Database.database().reference()
        var fireBaseAuth = Auth.auth()
        var postRef = self.ref.child("timeline").childByAutoId()
        
//        let postObject = [
//            "": [
//                "uid": UserProfile.uid,
//                "username": UserProfile.username,
//                "photoURL": UserProfile.photoURL.absoluteString
//            ],
//            "text": textField.text,
//            "timestamp": [".sv":"timestamp"]
//            ] as [String : Dictionary]
////
//        postRef.setValue(postObject, withCompletionBlock: { error, ref in
//            if error == nil {
//                self.dismiss(animated: true, completion: nil)
//            } else {
//                // Handle the error
//            }
//        })
        
        
    }
    
}

