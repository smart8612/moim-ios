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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        observeUserInformation()
        tableView.rowHeight = 200
        tableView.reloadData()
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        observeUserInformation()
        tableView.reloadData()
        
    }
    
    func clearUserData() {
        self.users.removeAll()
    }
    
    func observeUserInformation() {
        let usersRef = Database.database().reference().child("users")
        
        usersRef.observe(.value, with: { snapshot in
            for child in snapshot.children {
                print(child)
                guard let childSnapshot = child as? DataSnapshot else { return }
                guard let snapshotDic = childSnapshot.value as? Dictionary<String, Any> else { return }
                guard let uid = snapshotDic["uid"] as? String else { return }
                guard let email = snapshotDic["email"] as? String else { return }
                guard let name = snapshotDic["name"] as? String else { return }
                guard let nickname = snapshotDic["name"] as? String else { return }
                guard let gender = snapshotDic["gender"] as? String else { return }
                guard let birthday = snapshotDic["birthday"] as? String else { return }
                guard let phonenumber = snapshotDic["phonenumber"] as? String else { return }
                
                let tmpUser = User(uid: uid, email: email, userName: name, nickName: nickname, gender: gender, birthDay: birthday, phoneNumber: phonenumber)
                self.users.append(tmpUser)
                
            }
            self.tableView.reloadData()
        })
        print(self.users)
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
