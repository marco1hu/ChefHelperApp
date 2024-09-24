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


class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    var handle: AuthStateDidChangeListenerHandle?
    var reference: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        
        let ref = Database.database().reference()
        ref.child("antipasti").observe(.childAdded, with: { (snap) in
            if let dict = snap.value as? [String: AnyObject]{
                let title = dict["title"] as! String
                let image = dict["image"] as! String
                let category = dict["category"] as! String
                let difficulty = dict["difficulty"] as! String
                let habits = dict["habits"] as! String
                let id = dict["id"] as! Int
                let ingredients = dict["ingredients"] as! String
                let portions = dict["portions"] as! Int
                let steps = dict["steps"] as! String
                let time = dict["time"] as! String
                let year_period = dict["year_period"] as! String

                
          //      print(difficulty, habits, id)
            }
             })
            
            
            APIManager.shared.dataList = [
                RecipeModel(id: 0, title: "Spaghetti Cacio e Pepe", image: UIImage(named: "spagCacioPepe.jpeg")!, categorie: ["Primo"], dataId: 0, recipePostingDate: "2024-09-02" ),
                RecipeModel(id: 1, title: "Pasta Carbonara", image: UIImage(named: "carbonara.png")!, categorie: ["Primo"], dataId: 1, recipePostingDate: "2024-09-02" ),
                RecipeModel(id: 2,  title: "Rattaouille", image: UIImage(named: "ratatouille.jpeg")!, categorie: ["Contorno", "Senza glutine"], dataId: 2, recipePostingDate: "2024-09-02"),
                RecipeModel(id: 3, title: "Ravioli cinesi al vapore", image: UIImage(named: "ravioli.jpeg")!, categorie: ["Etnico"], dataId: 3, recipePostingDate: "2024-09-02"),
                RecipeModel(id: 4, title: "Spaghetti Alfredo", image: UIImage(named: "spagAlfredo.jpeg")!, categorie: ["Primo"], dataId: 4, recipePostingDate: "2024-09-02"),
                RecipeModel(id: 5, title: "Spaghetti allo Scoglio", image: UIImage(named: "spagScoglio.jpeg")!, categorie: ["Primo"], dataId: 5, recipePostingDate: "2024-09-02"),
                RecipeModel(id: 6, title: "1Spaghetti Cacio e Pepe", image: UIImage(named: "spagCacioPepe.jpeg")!, categorie: ["Primo"], dataId: 0, recipePostingDate: "2024-09-02" ),
                RecipeModel(id: 7, title: "1Pasta Carbonara", image: UIImage(named: "carbonara.png")!, categorie:["Primo"], dataId: 1, recipePostingDate: "2024-09-02" ),
                RecipeModel(id: 8,  title: "1Rattaouille", image: UIImage(named: "ratatouille.jpeg")!, categorie: ["Contorno"], dataId: 2, recipePostingDate: "2024-09-02"),
                RecipeModel(id: 9, title: "1Ravioli cinesi al vapore", image: UIImage(named: "ravioli.jpeg")!, categorie: ["Antipasto"], dataId: 3, recipePostingDate: "2024-09-02"),
                RecipeModel(id: 10, title: "1Spaghetti Alfredo", image: UIImage(named: "spagAlfredo.jpeg")!, categorie: ["Primo"], dataId: 4, recipePostingDate: "2024-09-02"),
                RecipeModel(id: 11, title: "1Spaghetti allo Scoglio", image: UIImage(named: "spagScoglio.jpeg")!, categorie: ["Primo"], dataId: 5, recipePostingDate: "2024-09-02"),
                RecipeModel(id: 0, title: "Spaghetti Cacio e Pepe", image: UIImage(named: "spagCacioPepe.jpeg")!, categorie:["Primo"], dataId: 0, recipePostingDate: "2024-09-02" ),
                RecipeModel(id: 12, title: "2Pasta Carbonara", image: UIImage(named: "carbonara.png")!, categorie: ["Primo"], dataId: 1, recipePostingDate: "2024-09-02" ),
                RecipeModel(id: 13,  title: "2Rattaouille", image: UIImage(named: "ratatouille.jpeg")!, categorie: ["Contorno", "Salsa", "Senza glutine"], dataId: 2, recipePostingDate: "2024-09-02"),
                RecipeModel(id: 14, title: "2Ravioli cinesi al vapore", image: UIImage(named: "ravioli.jpeg")!, categorie: ["Etnico", "Antipasto"], dataId: 3, recipePostingDate: "2024-09-02"),
                RecipeModel(id: 15, title: "2Spaghetti Alfredo", image: UIImage(named: "spagAlfredo.jpeg")!, categorie: ["Primo"], dataId: 4, recipePostingDate: "2024-09-02"),
                RecipeModel(id: 16, title: "2Spaghetti allo Scoglio", image: UIImage(named: "spagScoglio.jpeg")!, categorie: ["Primo"], dataId: 5, recipePostingDate: "2024-09-02"),
                RecipeModel(id: 17, title: "2Spaghetti Cacio e Pepe", image: UIImage(named: "spagCacioPepe.jpeg")!, categorie: ["Primo"], dataId: 0, recipePostingDate: "2024-09-02" ),
                RecipeModel(id: 18, title: "3Pasta Carbonara", image: UIImage(named: "carbonara.png")!, categorie: ["Primo"], dataId: 1, recipePostingDate: "2024-09-02" ),
                RecipeModel(id: 19,  title: "3Rattaouille", image: UIImage(named: "ratatouille.jpeg")!, categorie: ["Contorno"], dataId: 2, recipePostingDate: "2024-09-02"),
                RecipeModel(id: 20, title: "3Ravioli cinesi al vapore", image: UIImage(named: "ravioli.jpeg")!, categorie: ["Antipasto"], dataId: 3, recipePostingDate: "2024-09-02"),
                RecipeModel(id: 21, title: "3Spaghetti Alfredo", image: UIImage(named: "spagAlfredo.jpeg")!, categorie: ["Primo"], dataId: 4, recipePostingDate: "2024-09-02"),
                RecipeModel(id: 22, title: "3Spaghetti allo Scoglio", image: UIImage(named: "spagScoglio.jpeg")!, categorie: ["Primo"], dataId: 5, recipePostingDate: "2024-09-02")
            ]
        }
        
        
        //MARK: - Methods
        func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
            
            if tabBarController.selectedIndex == 3 || tabBarController.selectedIndex == 2 {
                
                handle = Auth.auth().addStateDidChangeListener { (auth, user) in
                    
                    if user == nil {
                        let storyboard = UIStoryboard(name: "Authorisation", bundle: nil)
                        
                        guard let navController = storyboard.instantiateViewController(withIdentifier: "AuthorisationNavigationController") as? UINavigationController else {
                            print("Failed to instantiate AuthorisationNavigationController")
                            return}
                        navController.modalPresentationStyle = .fullScreen
                        self.present(navController, animated: true)
                        tabBarController.selectedIndex = 0
                    }
                }
            }
        }
        
        
        
        
        
    }

