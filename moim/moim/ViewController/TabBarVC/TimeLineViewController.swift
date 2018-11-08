//
//  FirstViewController.swift
//  moim
//
//  Created by JeongTaek Han on 19/09/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import UIKit
import WebKit
import FirebaseDatabase
import FirebaseAuth

class TimeLineViewController: UIViewController {
    
    @IBOutlet var textField: UITextField!
    var ref: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let url = URL(string: "https://moimweb.herokuapp.com/timeline")
//        let request = URLRequest(url: url!)
//        webView.load(request)
    }
    

    @IBAction func closeButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        ref = Database.database().reference()
        var user = Auth.auth().currentUser!
        
    self.ref.child("users").child(user.uid).child("posts").setValue(["post2": "secondCommit"])
    }
    
}

