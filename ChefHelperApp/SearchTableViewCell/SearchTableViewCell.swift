//
//  SearchTableViewCell.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 22/09/24.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    
    static let reusableIdentifier = "SearchTableViewCell"
    

    override func awakeFromNib() {
        super.awakeFromNib()
        recipeImage.layer.cornerRadius = 10
        recipeImage.contentMode = .scaleAspectFill
    }
    

    func configureCell(with recipe: RecipeModel) {
        recipeTitle.text = recipe.title
        recipeImage.image = recipe.image
        
    }
    
}
