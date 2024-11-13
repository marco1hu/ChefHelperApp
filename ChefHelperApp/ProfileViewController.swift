//
//  ProfileViewController.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 01/09/24.
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore
import FirebaseDatabase

class ProfileViewController: UIViewController {

    @IBOutlet weak var logOutButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var accountButton: UIButton!
    @IBOutlet weak var prefButton: UIButton!
    @IBOutlet weak var notifyButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        // Do any additional setup after loading the view.
    }
    

    private func setupUI(){
        logOutButton.layer.cornerRadius = 15
        deleteButton.layer.cornerRadius = 15
        accountButton.layer.cornerRadius = 15
        prefButton.layer.cornerRadius = 15
        notifyButton.layer.cornerRadius = 15
    }
    
    @IBAction func handleLogOut(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
            do {
              try firebaseAuth.signOut()
            } catch  {
                self.present(Utilities.shared.alertErrorGeneral(error: "Logout fallito"), animated: true)
            }
    }
    
    @IBAction func handleDelete(_ sender: Any) {
        let user = Auth.auth().currentUser

        user?.delete { error in
          if let error = error {
              self.present(Utilities.shared.alertErrorGeneral(error: "Eliminazione fallita"), animated: true)
          } else {
              let ref = Database.database().reference()
              if let user = user {
                  let uid = user.uid
                  ref.child("users").child(uid).removeValue()
                  
                  try!  Auth.auth().signOut()
                  self.navigationController?.popToRootViewController(animated: true)
              }
          }
        }
    }
    

}
