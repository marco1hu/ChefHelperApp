//
//  ForgotPasswordViewController.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 15/09/24.
//

import UIKit
import FirebaseAuth

class ForgotPasswordViewController: UIViewController {
    @IBOutlet weak var emailTextField: FloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI(){
        emailTextField.cornerRadius = 15
        emailTextField.placeholder = "Email"
        emailTextField.leftImage = "icon.person.png"
        emailTextField.FLTextFieldBackgroundColor = UIColor.appColor3
        emailTextField.containerView.textfield.textContentType = .emailAddress
        emailTextField.containerView.textfield.keyboardType = .emailAddress
    }
    
    
    @IBAction func handleRecoveryButton(_ sender: Any) {
        
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { error in
            
            if self.emailTextField.text?.isEmpty==true || error != nil {
                self.present(Utilities.shared.alertErrorGeneral(error: "Reset fallito"), animated: true)
                        } else {
                            self.present(Utilities.shared.alertErrorGeneral(error: "Email di reset inviata"), animated: true)
                        }
        }
    }
}
