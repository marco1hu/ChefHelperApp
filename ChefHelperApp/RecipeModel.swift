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
    let portions: Int
    let difficulty: String
    let ingredients: String
    let steps: String
    let image: String
    let category: [String]?
    let habits: String
    let time: String
    let year_period: String
    let dataId: Int
    
    
    
    init(id: Int, title: String, portions:Int, difficulty: String, ingredients: String, steps: String, image: String, category: [String]?, habits: String, time: String, year_period: String, dataId: Int) {
        self.id = id
        self.title = title
        self.portions = portions
        self.difficulty = difficulty
        self.ingredients = ingredients
        self.steps = steps
        self.image = image
        self.category = category
        self.habits = habits
        self.time = time
        self.year_period = year_period
        self.dataId = dataId
    }

}
