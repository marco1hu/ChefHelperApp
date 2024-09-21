//
//  ForgotPasswordViewController.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 15/09/24.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var emailTextField: FloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        emailTextField.cornerRadius = 15
    }

  
}
