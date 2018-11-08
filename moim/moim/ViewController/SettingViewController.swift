//
//  SettingViewController.swift
//  
//
//  Created by JeongTaek Han on 28/10/2018.
//

import UIKit
import Firebase

class SettingViewController: UIViewController {

    @IBOutlet var signOutButton: UIBarButtonItem!
    let fireBaseAuth = Auth.auth()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func signOutButtonClicked(_ sender: UIBarButtonItem) {
        
//        let st = self.storyboard
//        let vc = st?.instantiateViewController(withIdentifier: "loginNavigationView") as! UIViewController
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "loginNavigationView") 
        
        do {
            try fireBaseAuth.signOut()
            self.present(vc, animated: true, completion: nil)
                
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError.localizedDescription)")
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
