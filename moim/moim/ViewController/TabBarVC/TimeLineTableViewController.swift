//
//  TimeLineTableViewController.swift
//  moim
//
//  Created by JeongTaek Han on 08/11/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import UIKit
import Firebase
import ViewAnimator

class TimeLineTableViewController: UITableViewController {
    
    private var posts = [Post]()
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    let fromAnimation = AnimationType.from(direction: .right, offset: 30.0)
    let zoomAnimation = AnimationType.zoom(scale: 0.2)
    let rotateAnimation = AnimationType.rotate(angle: CGFloat.pi/6)

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "PostTableViewCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "PostTableViewCell")
        tableView.backgroundColor = UIColor(white: 0.90,alpha:1.0)
        
        setupActivityIndicator()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupActivityIndicator()
        postsInitializer()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        clearPostsList()
        tableView.reloadData()
    }
    
    private func setupActivityIndicator() {
        activityIndicator.center = CGPoint(x: view.center.x, y: 100.0)
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func setUpAnimation() {
        activityIndicator.stopAnimating()
        tableView.reloadData()
        UIView.animate(
            views: tableView.visibleCells,
            animations: [
                fromAnimation,
                zoomAnimation
            ],
            delay: 0.5
        )
    }


    // MARK: - Table view data source
    
    private func observePosts(snapshot: DataSnapshot, uid: String) {
        for snapshotChild in snapshot.children.allObjects {
            let friend = snapshotChild as! DataSnapshot
            let postsRef = Database.database().reference().child("posts/\(friend.key)")
            
            postsRef.observeSingleEvent(of: .value, with: { postSnapshot in
                for child in postSnapshot.children.allObjects {
                    let post = child as! DataSnapshot
                    let postDic = post.value as! Dictionary<String, Any>
                    
                    guard let postId = postDic["postId"] as? String else { return }
                    guard let text = postDic["text"] as? String else { return }
                    guard let url = postDic["url"] as? String else { return }
                    
                    let tmpPost = Post(uid: friend.key, postId: postId, text: text, url: url)
                    self.posts.append(tmpPost)
                }
                print(self.posts)
                self.posts.sort(by: { (posta: Post, postb: Post) -> Bool in
                    return posta.postId > postb.postId
                })
                self.tableView.reloadData()
                self.setUpAnimation()
            })
        }

    }
    
    func postsInitializer() {
        let firebaseAuth = Auth.auth()
        guard let currentUid = firebaseAuth.currentUser?.uid else { return }
        let userRef = Database.database().reference().child("users/\(currentUid)/friends")
        self.clearPostsList()
        userRef.observeSingleEvent(of: .value, with: {snapshot in
            if snapshot.exists() {
                self.observePosts(snapshot: snapshot, uid: currentUid)
            }
        })
    }
    
    func clearPostsList() {
        self.posts.removeAll()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as! PostTableViewCell

        // Configure the cell...
        cell.selectionStyle = .none
        let row = indexPath.row
        
        let userRef = Database.database().reference().child("users/\(self.posts[row].uid)")
        userRef.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children.allObjects {
                let infoSnapshot = child as! DataSnapshot
                
                if infoSnapshot.key == "name" {
                    cell.usernameLabel.text = infoSnapshot.value as? String
                    break
                }
                
            }
            cell.set(post: self.posts[row])
            cell.commentButton.tag = indexPath.row
            cell.commentButton.addTarget(self, action: #selector(self.segueComments), for: .touchUpInside)
        })

        return cell
    }
    
    @objc private func segueComments(sender: UIButton) {
        performSegue(withIdentifier: "commentSegue", sender: sender)
    }

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "commentSegue" {
            let destination = segue.destination as? CommentsTableViewController
            let button = sender as! UIButton
            destination!.data = [
                "posts": self.posts,
                "index": button.tag
            ]
        }
    }

}
