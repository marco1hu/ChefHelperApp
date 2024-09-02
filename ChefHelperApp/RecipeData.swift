//
//  RecipeData.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 02/09/24.
//

import Foundation

public class RecipeData{
    let id: Int
    let title: String
    let subtitle: String?
    let portions: Int
    let difficulty: String
    let ingredients: [String]
    let steps: [String]
    let author: String
    
    init(id: Int, title: String, subtitle: String?, portions:Int, difficulty: String, ingredients: [String], steps: [String], author: String) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.portions = portions
        self.difficulty = difficulty
        self.ingredients = ingredients
        self.steps = steps
        self.author = author
    }
}
