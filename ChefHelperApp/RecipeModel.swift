//
//  RecipeModel.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 02/09/24.
//

import Foundation
import UIKit

public class RecipeModel{
    let id: Int
    let title: String
    let image: UIImage //TODO: Image Base64??
    let categorie: [String]
    let dataId: Int
    let recipePostingDate: String
    
    
    init(id: Int, title: String, image: UIImage, categorie: [String], dataId: Int, recipePostingDate:String) {
        self.id = id
        self.title = title
        self.image = image
        self.categorie = categorie
        self.dataId = dataId
        self.recipePostingDate = recipePostingDate
    }

}
