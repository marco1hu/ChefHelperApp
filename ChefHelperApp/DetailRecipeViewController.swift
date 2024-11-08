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
    public var categorie: [String]!
    public var recipeData: RecipeData!
    
    //MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        detailTableView.dataSource = self
        detailTableView.delegate = self
        
        detailTableView.estimatedRowHeight = 100
        detailTableView.rowHeight = UITableView.automaticDimension
        
        detailTableView.register(UINib(nibName: "DetailRecipe0TableViewCell", bundle: nil), forCellReuseIdentifier: DetailRecipe0TableViewCell.reusableIdentifier)
        detailTableView.register(UINib(nibName: "DetailRecipe1TableViewCell", bundle: nil), forCellReuseIdentifier: DetailRecipe1TableViewCell.reusableIdentifier)
        detailTableView.register(UINib(nibName: "DetailRecipe2TableViewCell", bundle: nil), forCellReuseIdentifier: DetailRecipe2TableViewCell.reusableIdentifier)
    }
    
    //MARK: - TableView Configuration and Delegates
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 2:
            return recipeData.steps.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailRecipe0TableViewCell.reusableIdentifier,
                                                     for: indexPath) as! DetailRecipe0TableViewCell
            
            cell.titleLabel.text = recipeData.title
            cell.recipeMainImageView.image = self.image
           // cell.author = recipeData.author
            
            
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailRecipe1TableViewCell.reusableIdentifier,
                                                     for: indexPath) as! DetailRecipe1TableViewCell
            
            cell.categoriaTextLabel.text = categorie.joined(separator: ", ")
            cell.difficultyLevelComponent.levelDifficulty = recipeData.difficulty
            cell.porzioniTextLabel.text = String(recipeData.portions)
            let ingredients = recipeData.ingredients.map { "• " + $0 }.joined(separator: "\n")
            cell.ingredientiTextLabel.text = ingredients
            
            return cell
        case 2:         
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailRecipe2TableViewCell.reusableIdentifier,
                                                     for: indexPath) as! DetailRecipe2TableViewCell

            cell.stepTitleLabel.text = "Step n° \(indexPath.row + 1)"
            cell.stepDescription.text = recipeData.steps[indexPath.row]
            
            return cell
        default:
            let cell = UITableViewCell()
            
            cell.backgroundColor = UIColor.appColor3
            
            return cell
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return view.bounds.height - ((3/10)*view.bounds.height)
        case 1:
            return UITableView.automaticDimension
        case 2:
            return UITableView.automaticDimension
        default:
            return 60
        }
    }
    

}
