//
//  LottiCollectionViewCell.swift
//  all-in-ios
//
//  Created by IFTS40 on 06/08/24.
//

import UIKit

/// Reusable cell di LottiCollectionView
class RicettaCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nomeLabel: UILabel!
    
    static let reusableIdentifier: String = "lottoCell"
    
    //MARK: - App Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }
    
    //MARK: - UI Setup Methods
    
    private func updateUI(){
        
        backView.layer.cornerRadius = 15
        backView.layer.borderWidth = 1
        backView.layer.borderColor = UIColor.black.cgColor
        backView.clipsToBounds = true
        
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.contentMode = .scaleAspectFill
    
    }


}
