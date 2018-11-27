//
//  PostTableViewCell.swift
//  FirebaseApp
//
//  Created by Robert Canton on 2018-02-08.
//  Copyright © 2018 Robert Canton. All rights reserved.
//

import UIKit
import Firebase

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var commentLabel: UITextField!
    @IBOutlet weak var commentButton: UIButton!
    var post: Post!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(post: Post) {
        self.post = post
        postTextLabel.text = post.text
    }
    
    // When Editing textfield is finished, Hide Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.endEditing(true)
        
    }
    
    @IBAction func sendButtonClicked(_ sender: UIButton) {
        let postUid = self.post.uid
        let currentUid = Auth.auth().currentUser?.uid
        let postId = self.post.postId
        let commentId = Date().millisecondsSince1970
        let commentRef = Database.database().reference().child("posts/\(postUid)/\(postId)/comments/\(commentId)")
        commentRef.setValue([
            "uid": currentUid,
            "text": commentLabel.text
        ])
        
        commentLabel.text = nil
    }
    
}
