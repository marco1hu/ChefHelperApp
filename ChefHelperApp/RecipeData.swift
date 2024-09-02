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
    let difficulty: String
    let ingredients: [String]
    let steps: [String]
    let author: String
    
    init(id: Int, title: String, subtitle: String?, difficulty: String, ingredients: [String], steps: [String], author: String) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.difficulty = difficulty
        self.ingredients = ingredients
        self.steps = steps
        self.author = author
    }
}
