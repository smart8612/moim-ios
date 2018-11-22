//
//  SignInEmailViewController.swift
//  moim
//
//  Created by JeongTaek Han on 22/11/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import UIKit

class SignUpEmailViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendEmailText(_ sender: UIButton) {
        performSegue(withIdentifier: "showPasswordSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPasswordSegue" {
            let passwordVC = segue.destination as! SignUpPasswordViewController
            
            passwordVC.data = [
                "email": emailField.text
            ]
        }
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
