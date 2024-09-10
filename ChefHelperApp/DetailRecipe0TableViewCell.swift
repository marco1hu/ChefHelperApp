//
//  DetailRecipe0TableViewCell.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 03/09/24.
//

import UIKit

class DetailRecipe0TableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var recipeMainImageView: UIImageView!
    
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var heartButton: UIButton!
    
    var author: String? {
        didSet{
            authorLabel.text = "Una ricetta di \(author!)"
        }
    }
    
    var subtitle: String? {
        didSet{
            subtitleLabel.text = subtitle!
        }
    }
    static let reusableIdentifier = "detail0Cell"
    
    var id: Int?
   
    //TODO: - Implementare onSaveButtonPressed in Details e logica per vedere se l'utente lha già salavato. Se sì heartButtonIsSelected = true
    var onSaveButtonPressed: ((Int, Bool)->Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI(){
        recipeMainImageView.layer.cornerRadius = 8

        recipeMainImageView.contentMode = .scaleAspectFill
        authorLabel.text = ""
        subtitleLabel.text = ""
        self.selectionStyle = .none
    }
    
    @IBAction func heartPressed(_ sender: UIButton) {
        heartButton.isSelected = !heartButton.isSelected
        
        guard let id = id else{ return }
        onSaveButtonPressed?(id, heartButton.isSelected)
    }
}
