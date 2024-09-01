//
//  TextFieldRightView.swift
//  all-in-ios
//
//  Created by IFTS40 on 26/07/24.
//

import UIKit

/// View a destra della Textfield
class TextFieldRightView: UIView {
    
    var imageOn = "" {
        didSet{
            if imageOn != oldValue{
                button.setImage(UIImage(named: imageOn), for: .normal)
            }
        }
    }
    var imageOff = "" {
        didSet{
            if imageOff != oldValue{
                button.setImage(UIImage(named: imageOff), for: .selected)
            }
        }
    }

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var button: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("TextFieldRightView", owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .clear
        
    }
    
    @IBAction func handleButton(_ sender: UIButton) {
        button.isSelected = !button.isSelected
    }
}
