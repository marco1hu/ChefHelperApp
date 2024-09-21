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
    private let height: CGFloat = 30
    var isSelectedCell: Bool = false
    
    public var handleSelection: ((String)->Void)?
    public var handleDeselection: ((String)->Void)?
    
    
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
        
        
        NSLayoutConstraint.activate([
            backView.leftAnchor.constraint(equalTo: label.leftAnchor, constant: -10),
            backView.rightAnchor.constraint(equalTo: label.rightAnchor, constant: 10),
            backView.heightAnchor.constraint(equalToConstant: height)
            
        ])
        
        
    }
    
    func toggleSelected (){
        DispatchQueue.main.async {
            if self.isSelectedCell {
                self.setSelected()
                self.handleSelection?(self.label.text!)
            }else{
                self.setDeselected()
                self.handleDeselection?(self.label.text!)
            }
        }
    }
    
    func setSelected(){
        backView.backgroundColor = #colorLiteral(red: 0.5803921569, green: 0.7058823529, blue: 0.6235294118, alpha: 1)
    }
    
    func setDeselected(){
        backView.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.9725490196, blue: 0.9098039216, alpha: 1)
    }
}
