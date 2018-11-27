//
//  CommentsTableViewController.swift
//  moim
//
//  Created by JeongTaek Han on 27/11/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import UIKit
import Firebase

class CommentsTableViewController: UITableViewController {
    
    var data: Any?
    var cellDataInfo: Dictionary<String, Any>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.cellDataInfo = self.data as? Dictionary<String, Any>
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        commentsInitialize()
    }
    
    private func observeComments(snapshot: DataSnapshot) {
        for snapshotChild in snapshot.children.allObjects {
            let comments = snapshotChild as! DataSnapshot
            print(comments)
//            let postsRef = Database.database().reference().child("posts/\(friend.key)")
//
//            postsRef.observeSingleEvent(of: .value, with: { postSnapshot in
//                for child in postSnapshot.children.allObjects {
//                    let post = child as! DataSnapshot
//                    let postDic = post.value as! Dictionary<String, Any>
//
//                    guard let postId = postDic["postId"] as? String else { return }
//                    guard let text = postDic["text"] as? String else { return }
//                    guard let url = postDic["url"] as? String else { return }
//
//                    let tmpPost = Post(uid: friend.key, postId: postId, text: text, url: url)
//
//                }
//            })
        }
        
    }
    
    func commentsInitialize() {
        let posts = cellDataInfo["posts"] as! [Post]
        let index = cellDataInfo["index"] as! Int
        let post = posts[index]
        let url = "posts/\(post.uid)/\(post.postId)/comments"
        let commentsRef = Database.database().reference().child(url)
        
        commentsRef.observeSingleEvent(of: .value, with: {snapshot in
            self.observeComments(snapshot: snapshot)
        })
        
    
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
