//
//  TextFieldLeftView.swift
//  all-in-ios
//
//  Created by IFTS40 on 25/07/24.
//

import UIKit

/// View a sinistra della Textfield
class TextFieldLeftView: UIView {
    
    var image = "" {
        didSet{
            if image != oldValue {
                imageView.image = UIImage(named: image)
            }
        }
    }
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        Bundle.main.loadNibNamed("TextFieldLeftView", owner: self)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.backgroundColor = .clear
    }
}
