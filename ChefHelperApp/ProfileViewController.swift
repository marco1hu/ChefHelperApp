//
//  ProfileViewController.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 01/09/24.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    

    private func setupUI(){
        logOutButton.layer.cornerRadius = 15
    }
    
    @IBAction func handleLogOut(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
            } catch  {
                self.present(Utilities.shared.alertErrorGeneral(error: "Logout fallito"), animated: true)
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
