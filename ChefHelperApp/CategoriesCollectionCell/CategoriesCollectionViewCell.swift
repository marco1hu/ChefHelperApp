//
//  CategoriesCollectionCell.swift
//
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
    var isSelectedCell: Bool = false{
        didSet {
            toggleSelected()
        }
    }

    
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
        
        label.textColor = UIColor.black
        
        
        backView.layer.cornerRadius = 10
        backView.backgroundColor = UIColor.appColor3
//        backView.layer.borderWidth = 1
//        backView.layer.borderColor = UIColor.appColor4.cgColor
        
       
        NSLayoutConstraint.activate([
            backView.leftAnchor.constraint(equalTo: label.leftAnchor, constant: -10),
            backView.rightAnchor.constraint(equalTo: label.rightAnchor, constant: 10),

        ])
        
        
    }
    
    func toggleSelected (){
        DispatchQueue.main.async {
            if self.isSelectedCell {
                self.setSelected()
               
            }else{
                self.setDeselected()
            }
        }
    }
    
    func setSelected(){
        backView.backgroundColor = UIColor.appColor4
    }
    
    func setDeselected(){
        backView.backgroundColor = UIColor.appColor5
    }
}
