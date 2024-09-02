//
//  DetailRecipeViewController.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 02/09/24.
//

import UIKit

class DetailRecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var detailTableView: UITableView!
    
    public var image: UIImage!
    public var recipeData: RecipeData!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailTableView.dataSource = self
        detailTableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    

}
