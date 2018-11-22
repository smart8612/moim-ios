//
//  SiginInPersonalViewController.swift
//  moim
//
//  Created by JeongTaek Han on 22/11/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import UIKit
import Firebase

class SiginUpPersonalViewController: UIViewController {
    
    var data: Dictionary<String, String?> = [:]
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var birthdayDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(self.data)
    }
    
    @IBAction func unwindToRoot(unwindSegue: UIStoryboardSegue) {
        initialUserDB()
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private func initialUserDB() {
        let user = initialUserObject()
        let userRef = Database.database().reference().child("users/\(user.uid)")
        userRef.setValue(user.getUserDataDictionary())
    }
    
    private func initialUserObject() -> User {
        let currentUser = Auth.auth().currentUser
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        
        let uid = currentUser?.uid
        let email = currentUser?.email
        let name = nameField.text
        let gender = genderField.text
        let nickname = nicknameField.text
        let phoneNumber = phoneNumberField.text
        let birthday = dateFormatter.string(from: birthdayDatePicker.date)
        
        let user = User(
            uid: uid!, email: email!, userName: name!,
            nickName: nickname!, gender: gender!,
            birthDay: birthday, phoneNumber: phoneNumber!
        )
        
        return user
    }
    
    // When Editing textfield is finished, Hide Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
