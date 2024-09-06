//
//  DetailRecipe1TableViewCell.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 03/09/24.
//

import UIKit

class DetailRecipe1TableViewCell: UITableViewCell {

    @IBOutlet weak var categoriaTextLabel: UILabel!
    @IBOutlet weak var difficultyLevelComponent: DifficultyLevelComponent!
    @IBOutlet weak var porzioniTextLabel: UILabel!
    @IBOutlet weak var ingredientiTextLabel: UILabel!
    
    var difficulty: Int?{
        didSet{
            DispatchQueue.main.async {
                self.difficultyLevelComponent.levelDifficulty = self.difficulty
            }
            
        }
    }
    static var reusableIdentifier = "detail1Cell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }

    private func setup(){
        self.selectionStyle = .none
    }

    
}
