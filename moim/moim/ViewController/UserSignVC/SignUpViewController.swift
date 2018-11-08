//
//  SignUpViewController.swift
//  moim
//
//  Created by JeongTaek Han on 27/09/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField?
    @IBOutlet weak var passwordField: UITextField?
    @IBOutlet weak var signUpButton: UIButton?
    
    let fireBaseAuth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // When Editing textfield is finished, Hide Keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    @IBAction func signUpButtonClicked(_ sender: UIButton) {
        guard let email = emailField?.text else { return }
        guard let password = passwordField?.text else { return }
        
        fireBaseAuth.createUser(withEmail: email, password: password) { user, error in
            if error == nil && user != nil {
                print("user created")
            } else {
                print("Error Creating User: \(String(describing: error?.localizedDescription))")
            }
        }
        
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
