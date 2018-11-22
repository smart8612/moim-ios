//
//  SignInPasswordViewController.swift
//  moim
//
//  Created by JeongTaek Han on 22/11/2018.
//  Copyright © 2018 teammoim. All rights reserved.
//

import UIKit

class SignUpPasswordViewController: UIViewController {
    
    var data: Dictionary<String, String?> = [:]
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print(self.data)
    }
    
    @IBAction func sendPassword(_ sender: UIButton) {
        performSegue(withIdentifier: "showPersonalSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showPersonalSegue" {
            let personalVC = segue.destination as! SiginUpPersonalViewController
            
            self.data["Password"] = self.passwordField.text
            
            personalVC.data = self.data
            
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
