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
    
    var userList = [String]()
    var userObjArray = [User]()
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        clearUserData()
        
        tableView.rowHeight = 200
        tableView.reloadData()
  
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        clearUserData()
        
        tableView.reloadData()
        
        observeUsers()
        observeUserInformation()
        
    }
    
    func clearUserData() {
        self.userList.removeAll()
        self.userObjArray.removeAll()
        
    }
    
    func observeUsers() {
        let usersRef = Database.database().reference().child("userList")
        
        usersRef.observe(.value, with: { snapshot in
            var userList = [String]()
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot {
                    let uid = childSnapshot.key
                    userList.append(uid)
                }
            }
            self.userList = userList
            print(userList)
        })
    }
    
    func observeUserInformation() {
        let usersRef = Database.database().reference()
        
        usersRef.observe(.value, with: { snapshot in
            for child in snapshot.children {
                if let childSnapshot = child as? DataSnapshot,
                    let dic = childSnapshot.value as? Dictionary<String, String>,
                    let uid = dic["uid"],
                    let name = dic["name"],
                    let email = dic["email"] {
//                    let tmpUser = User(uid: uid, email: email, username: name,)
//                    self.userObjArray.append(tmpUser)
                }
            }
            print(self.userObjArray)
            self.tableView.reloadData()
        })
        
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.userObjArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendTableCell", for: indexPath) as! FriendTableViewCell
        
        let row = indexPath.row
        
        
        cell.friendNameLabel.text = userObjArray[row].name
//        cell.friendProfileImage.image = UIImage(named: friendImage[0])
        cell.friendStatusLabel.text = userObjArray[row].email

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
