//
//  MainTabBarController.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 01/09/24.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var handle: AuthStateDidChangeListenerHandle?
    var reference: DatabaseReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        
        
    }
    
    
    
    

    // MARK: - Methods
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 3 || tabBarController.selectedIndex == 2 {
            handle = Auth.auth().addStateDidChangeListener { (auth, user) in
                if user == nil {
                    let storyboard = UIStoryboard(name: "Authorisation", bundle: nil)
                    
                    guard let navController = storyboard.instantiateViewController(withIdentifier: "AuthorisationNavigationController") as? UINavigationController else {
                        print("Failed to instantiate AuthorisationNavigationController")
                        return
                    }
                    navController.modalPresentationStyle = .fullScreen
                    self.present(navController, animated: true)
                    tabBarController.selectedIndex = 0
                }
            }
        }
    }
}

