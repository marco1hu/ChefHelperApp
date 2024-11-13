//
//  SearchViewController.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 01/09/24.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultsTableView: UITableView!
    
    var filterData: [RecipeModel]!
    override func viewWillAppear(_ animated: Bool) {
        print("SearchViewController viewWillAppear")
        filterData = APIManager.shared.dataList.sorted(by: { recipe1, recipe2 in
            recipe1.title!.lowercased() < recipe2.title!.lowercased()
        })
        resultsTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        resultsTableView.register(UINib(nibName: "SearchTableViewCell", bundle: nil),
                                  forCellReuseIdentifier: SearchTableViewCell.reusableIdentifier)
        hideKeyboardWhenTappedAround()
        searchBar.delegate = self
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.reusableIdentifier) as! SearchTableViewCell
        cell.configureCell(with: filterData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(filterData[indexPath.row].title!)
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "detailRecipe") as? DetailRecipeViewController else { return }
        getRecipesDataById(id: filterData[indexPath.row].dataId!) { data in
            if let data = data {
                vc.recipeData = data
                vc.categorie = self.filterData[indexPath.item].category
                vc.image = self.filterData[indexPath.item].image
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
            }
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData = []
        if searchText == ""{
            filterData = APIManager.shared.dataList
        }
        
        for recipe in APIManager.shared.dataList{
            if recipe.title!.uppercased().contains(searchText.uppercased()){
                filterData.append(recipe)
            }
        }
        self.resultsTableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filterData = APIManager.shared.dataList
        self.resultsTableView.reloadData()
    }
    
    private func getRecipesDataById(id: Int, completion: @escaping (RecipeData?)->Void){
        //TODO: chiamata API
        let ref = Database.database().reference()
        
        ref.child("ricettario").queryOrdered(byChild: "id").queryEqual(toValue: id).observeSingleEvent(of: .value, with: { (snap) in
            for child in snap.children.allObjects as! [DataSnapshot] {
                if let data = child.value as? [String: AnyObject]{
                    let title = data["title"] as! String
                    let difficulty = data["difficulty"] as! Int
                    let id = data["id"] as! Int
                    let ingredients = data["ingredients"] as! [String]
                    let portions = data["portions"] as! Int
                    let steps = data["steps"] as! [String]
                    
                    
                    completion(RecipeData(id: id, title: title, portions: portions, difficulty: difficulty, ingredients: ingredients, steps: steps))
                }
            }
            
        })
        
    }
    
    
    //MARK: - Funzioni gestione tastiera
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
