//
//  RegistrationViewController.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 15/09/24.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class RegistrationViewController: UIViewController {

    @IBOutlet weak var nomeTextField: FloatingLabelTextField!
    @IBOutlet weak var emailTextField: FloatingLabelTextField!
    @IBOutlet weak var passwordTextField: FloatingLabelTextField!
    @IBOutlet weak var confirmPasswordTextField: FloatingLabelTextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
     

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
    
    private func setupUI(){
        signUpButton.layer.cornerRadius = 15
        emailTextField.cornerRadius = 15
        passwordTextField.cornerRadius = 15
        nomeTextField.cornerRadius = 15
        confirmPasswordTextField.cornerRadius = 15

        emailTextField.placeholder = "Email"
        emailTextField.leftImage = "icon.person.png"

        passwordTextField.placeholder = "Password"
        passwordTextField.leftImage = "icon.lock.png"
        passwordTextField.rightImageOn = "x-eye-icon.png"
        passwordTextField.rightImageOff = "eye-icon.png"
        
        nomeTextField.placeholder = "Nome utente"
        nomeTextField.leftImage = "icon.person.png"
        
        confirmPasswordTextField.placeholder = "Conferma password"
        confirmPasswordTextField.leftImage = "icon.lock.png"
        confirmPasswordTextField.rightImageOn = "x-eye-icon.png"
        confirmPasswordTextField.rightImageOff = "eye-icon.png"
        
        nomeTextField.textfieldTag = 0
        emailTextField.textfieldTag = 1
        passwordTextField.textfieldTag = 2
        confirmPasswordTextField.textfieldTag = 3
        
        emailTextField.containerView.textfield.textContentType = .emailAddress
        emailTextField.containerView.textfield.keyboardType = .emailAddress
        passwordTextField.containerView.textfield.textContentType = .password
        confirmPasswordTextField.containerView.textfield.textContentType = .password
        
        emailTextField.containerView.textfield.autocorrectionType = .no
        
        emailTextField.FLTextFieldBackgroundColor = UIColor.appColor3
        passwordTextField.FLTextFieldBackgroundColor = UIColor.appColor3
        nomeTextField.FLTextFieldBackgroundColor = UIColor.appColor3
        confirmPasswordTextField.FLTextFieldBackgroundColor = UIColor.appColor3
        
        
        
    }
    
    
    //MARK: - IBActions
    @IBAction func handleSignUpButton(_ sender: Any) {
        
        let validEmail = Utilities.shared.isValidEmail(emailTextField.text!)
        let validPassword = Utilities.shared.isValidPassword(passwordTextField.text!)
        let validConfirmPassword = Utilities.shared.isValidPassword(confirmPasswordTextField.text!)
        
        if (passwordTextField.text! != confirmPasswordTextField.text!) {
            self.present(Utilities.shared.alertErrorGeneral(error: "Errore, le password non coincidono. Riprova."), animated: true)
        } else {
            if (validEmail && validPassword == true && validPassword == validConfirmPassword){
                Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!){ authResult, error in
                    if error != nil{
                        self.present(Utilities.shared.alertErrorGeneral(error: "Qualcosa è andato storto. L'utente non è stato creato. Riprova."), animated: true)
                        print("Codice errore: \(error!.localizedDescription)")
                        
                    }else{
                        let reference = Database.database(url: "https://chefhelper-ae6a9-default-rtdb.europe-west1.firebasedatabase.app/").reference()
                        reference.child("users").child(Auth.auth().currentUser!.uid).setValue(["ID" : Auth.auth().currentUser!.uid, "Nome_utente": self.nomeTextField.text!, "Email": self.emailTextField.text!, "Pasword": self.passwordTextField.text!])
                        
                        self.dismiss(animated: true)
                    }
                    self.present(Utilities.shared.alertErrorGeneral(error: "Complimenti, il tuo account è stato correttamente creato."), animated: true)
                }
            }else{
                self.present(Utilities.shared.alertErrorGeneral(error: "Errore, i dati che hai inserito non sono validi. Riprova."), animated: true)
                
            }
        }
        
        
    }
    
    
    
//    //MARK: - Funzioni gestione tastiera
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
//    
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            let spacing = keyboardSize.height/5
//            self.view.frame.origin.y = -spacing
//        }
//    }
//    
//    @objc func keyboardWillHide(notification: NSNotification) {
//        self.view.frame.origin.y = 0
//    }
//    
//    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}
