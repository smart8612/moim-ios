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
        
        guard let uid = fireBaseAuth.currentUser?.uid else { return }
        guard let text = textField.text else { return }
        let postId = String(Date().millisecondsSince1970)
        let url = String()
        
        let tmpPost = Post(uid: uid, postId: postId, text: text, url: url)
        self.post = tmpPost.getPostDataDictionary()
        
        let postRef = self.ref.child("post/\(uid)/\(postId)")
        
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

