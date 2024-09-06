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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI(){
        recipeMainImageView.layer.cornerRadius = 8
//        recipeMainImageView.layer.borderColor = UIColor.black.cgColor
//        recipeMainImageView.layer.borderWidth = 1
        recipeMainImageView.contentMode = .scaleAspectFill
        authorLabel.text = ""
        subtitleLabel.text = ""
        self.selectionStyle = .none
    }
    
}
