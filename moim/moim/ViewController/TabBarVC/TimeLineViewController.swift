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
    var post: Dictionary<String,String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    

    @IBAction func closeButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        ref = Database.database().reference()
        let fireBaseAuth = Auth.auth()
        let postRef = self.ref.child("timeline/\(Date().millisecondsSince1970)")
        
        if let name: String = fireBaseAuth.currentUser?.email,
            let text: String = textField.text {
            self.post = [
                "name": name,
                "text": text
            ]
        }
        
        postRef.setValue(post, withCompletionBlock: { error, ref in
            if error == nil {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Handle the error
            }
        })
        
        
    }
    
}

extension Date {
    var millisecondsSince1970:Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds:Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}

