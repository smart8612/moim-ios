//
//  LoginViewController.swift
//  moim
//
//  Created by JeongTaek Han on 27/09/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField?
    @IBOutlet weak var passwordField: UITextField?
    @IBOutlet weak var signInButton: UIButton?
    
    let fireBaseAuth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func signInButtonClicked(_ sender: UIButton) {
        guard let email = emailField?.text else { return }
        guard let password = passwordField?.text else { return }
        
        let st = self.storyboard
        let vc = st?.instantiateViewController(withIdentifier: "MainTabBarController") as! UITabBarController
        
        if password.count >= 8 {
            fireBaseAuth.signIn(withEmail: email, password: password) { user, error in
                if error == nil && user != nil {
                    print("Sign In Complete")
                    self.present(vc, animated: true, completion: nil)
                    
                } else {
                    print("Error Occur: \(String(describing: error?.localizedDescription))")
                    self.loginErrorAlert()
                }
            }
        } else {
            loginErrorAlert()
        }
                
    }
    
    
    func loginErrorAlert() {
        let alert = UIAlertController(
            title: "Login Error Occur",
            message: "Please Check your Account",
            preferredStyle:  UIAlertController.Style.actionSheet
        )
        
        let confirmAction: UIAlertAction = UIAlertAction(
            title: "confirm",
            style: UIAlertAction.Style.default,
            handler:{
                (action: UIAlertAction!) -> Void in
                print("Confirm")
        })
        
        alert.addAction(confirmAction)
        self.present(alert, animated: true, completion: nil)
        
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
