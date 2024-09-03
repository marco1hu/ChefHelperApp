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
        detailTableView.register(UINib(nibName: "DetailRecipe0TableViewCell", bundle: nil), forCellReuseIdentifier: DetailRecipe0TableViewCell.reusableIdentifier)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return recipeData.steps.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailRecipe0TableViewCell.reusableIdentifier,
                                                     for: indexPath) as! DetailRecipe0TableViewCell
            
            cell.titleLabel.text = recipeData.title
            cell.recipeMainImageView.image = self.image
            cell.author = recipeData.author
            
            
            return cell
        case 1:
            return UITableViewCell()
        case 2:
            return UITableViewCell()
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.item{
        case 0:
            return view.bounds.height - ((3/10)*view.bounds.height)
        case 1:
            return 0
        case 2:
            return 0
        default:
            return 0
        }
    }
    

}
