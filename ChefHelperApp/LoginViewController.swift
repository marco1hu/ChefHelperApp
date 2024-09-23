//
//  LoginViewController.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 15/09/24.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: FloatingLabelTextField!
    
    @IBOutlet weak var passwordTextField: FloatingLabelTextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var forgotPasswordButton: UIButton!
    
    
    //MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func setupUI(){
        loginButton.layer.cornerRadius = 15
        emailTextField.cornerRadius = 15
        passwordTextField.cornerRadius = 15
        
        emailTextField.leftImage = "icon.person.png"
        passwordTextField.leftImage = "icon.lock.png"
        passwordTextField.rightImageOn = "x-eye-icon.png"
        passwordTextField.rightImageOff = "eye-icon.png"
        emailTextField.placeholder = "Username"
        passwordTextField.placeholder = "Password"
        emailTextField.textfieldTag = 0
        passwordTextField.textfieldTag = 1
        
        emailTextField.containerView.textfield.textContentType = .emailAddress
        emailTextField.containerView.textfield.keyboardType = .emailAddress
        passwordTextField.containerView.textfield.textContentType = .password
        
        
        emailTextField.FLTextFieldBackgroundColor = UIColor.appColor3
        passwordTextField.FLTextFieldBackgroundColor = UIColor.appColor3
        
    }
    
    //MARK: - IBActions
    @IBAction func handleLoginButton(_ sender: UIButton) {
        //Logiche di login
        
        UserDefaults.standard.set(true, forKey: "userLogged")
        self.dismiss(animated: true)
        
        if emailTextField.text?.replacingOccurrences(of: " ", with: "") == "" || passwordTextField.text?.replacingOccurrences(of: " ", with: "") == ""  {
            self.present(Utilities.shared.alertErrorGeneral(error: "Uno o più campi non sono stati compilati."), animated: true)
        
        }else {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                
                if error != nil{
                    
                    self!.present(Utilities.shared.alertErrorGeneral(error: "Un errore è stato riscontrato durante l'accesso."), animated: true)
                    print("Codice errore: \(error!.localizedDescription)")
                    
                }else{
                    self?.dismiss(animated: true)
                }
            }
        }
    }
    
    
    @IBAction func handleForgotButton(_ sender: UIButton) {
        storyboard?.instantiateViewController(withIdentifier: "ForgotPw")
    }
    
    
    
    
    //MARK: - Funzioni gestione tastiera
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let spacing = keyboardSize.height/5
            self.view.frame.origin.y = -spacing
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
   

}
