//
//  SearchViewController.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 01/09/24.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate{
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var resultsTableView: UITableView!
    
    var filterData: [RecipeModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterData = APIManager.shared.dataList
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
