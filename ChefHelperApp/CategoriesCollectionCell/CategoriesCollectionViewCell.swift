//
//  CategoriesCollectionCell.swift
//  all-in-ios
//
//  Created by IFTS40 on 06/08/24.
//

import UIKit

/// Reusable cell di CategoriesCollectionView
class CategoriesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var label: UILabel!
    
    
    static let reusableIdentifier = "categoriesCell"
    private let fontSize: CGFloat = 18
    private let height: CGFloat = 30
    var isSelectedCell: Bool = false
    var on: Bool = false //TODO: toggled or not toggled, magari da cmabiare nome
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateUI()
    }
    
    func updateUI(){
        
        if let categoriesDescriptor = UIFontDescriptor(name: "Helvetica Neue", size: fontSize).withSymbolicTraits([.traitBold]) {
            label.font = UIFont(descriptor: categoriesDescriptor, size: fontSize)
        } else {
            label.font = UIFont(name: "Helvetica Neue", size: fontSize)
        }
        
        label.textColor = UIColor.white
        
        
        backView.layer.cornerRadius = 10
        backView.backgroundColor = UIColor.white
        
        
        NSLayoutConstraint.activate([
            backView.leftAnchor.constraint(equalTo: label.leftAnchor, constant: -10),
            backView.rightAnchor.constraint(equalTo: label.rightAnchor, constant: 10),
            backView.heightAnchor.constraint(equalToConstant: height)
            
        ])
        
       
        
    }
    
    func toggleSelected (){
        self.on = !self.on
        DispatchQueue.main.async {
            if self.isSelectedCell {
                self.backView.backgroundColor = #colorLiteral(red: 0.4322821506, green: 0.0007069214061, blue: 0.1281887532, alpha: 1)
            }else{
                self.backView.backgroundColor = #colorLiteral(red: 0.7803921569, green: 0, blue: 0.2235294118, alpha: 1)
            }
        }
        
    }
    
}
