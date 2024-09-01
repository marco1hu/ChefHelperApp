//
//  MainTabBarController.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 01/09/24.
//

import UIKit

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    

    //MARK: - Methods
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        if tabBarController.selectedIndex == 3{
            let isLogged = UserDefaults.standard.bool(forKey: "userLogged")
            if !isLogged{
                
                let storyboard = UIStoryboard(name: "Authorisation", bundle: nil)
                
                guard let navController = storyboard.instantiateViewController(withIdentifier: "AuthorisationNavigationController") as? UINavigationController else {
                    print("Failed to instantiate AuthorisationNavigationController")
                    return
                }
                
                navController.modalPresentationStyle = .fullScreen
                present(navController, animated: true)
                tabBarController.selectedIndex = 0
                
            }
        }
    }

}
