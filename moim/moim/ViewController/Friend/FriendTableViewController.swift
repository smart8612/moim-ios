//
//  FriendTableViewController.swift
//  moim
//
//  Created by JeongTaek Han on 28/10/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import UIKit
import Firebase

class FriendTableViewController: UITableViewController {
    
    var users = [User]()
    var userCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.rowHeight = 200
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        clearUserData()
        observeUserInformation()
        tableView.reloadData()
    }
    
    func clearUserData() {
        self.users.removeAll()
    }
    
    func observeUserInformation() {
        let userRef = Database.database().reference().child("users")
        
        userRef.observeSingleEvent(of: .value, with: { snapshot in
            for child in snapshot.children.allObjects {
                let user = child as! DataSnapshot
                let userDic = user.value as! Dictionary<String, Any>
                
                guard let uid = userDic["uid"] else { return }
                guard let email = userDic["email"] else { return }
                guard let name = userDic["name"] else { return }
                guard let nickname = userDic["nickname"] else { return }
                guard let gender = userDic["gender"] else { return }
                guard let birthday = userDic["birthday"] else { return }
                guard let phone = userDic["phone"] else { return }
                
                let newUser = User(uid: uid as! String, email: email as! String, userName: name as! String, nickName: nickname as! String, gender: gender as! String, birthDay: birthday as! String, phoneNumber: phone as! String)
                
                if newUser.uid != Auth.auth().currentUser!.uid {
                    self.users.append(newUser)
                }
                self.tableView.reloadData()
            }
        })
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.users.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableCell", for: indexPath) as! FriendTableViewCell
        
        let row = indexPath.row
        
        
        cell.friendNameLabel.text = users[row].name
//        cell.friendProfileImage.image = UIImage(named: friendImage[0])
        cell.friendStatusLabel.text = users[row].email
        cell.uid = users[row].uid

        // Configure the cell...

        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
