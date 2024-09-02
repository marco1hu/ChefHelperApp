//
//  RecipeCollectionViewCell.swift
//
//
//  Created by IFTS40 on 06/08/24.
//

import UIKit

/// Reusable cell di LottiCollectionView
class RecipeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var componentView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var SuperView: UIView!
    
    static let reusableIdentifier: String = "recipeCell"
    private var shadowLayer: CAShapeLayer!
    
    //MARK: - App Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }
    
    //MARK: - UI Setup Methods
    
    private func updateUI(){
        
        SuperView.backgroundColor = UIColor.appColor3
        backView.layer.cornerRadius = 15
        backView.clipsToBounds = true
        componentView.layer.cornerRadius = 15
        imageView.contentMode = .scaleAspectFill
        
        componentView.layer.shadowColor = UIColor.black.cgColor
        componentView.layer.shadowOffset = CGSize(width: 2, height: 2)
        componentView.layer.shadowOpacity = 0.5
        componentView.layer.shadowRadius = 4.0

    
    }


}
