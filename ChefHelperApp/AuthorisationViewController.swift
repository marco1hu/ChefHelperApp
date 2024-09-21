//
//  AuthorisationViewController.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 01/09/24.
//

import UIKit
import Lottie

class AuthorisationViewController: UIViewController {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var logoView: UIImageView!
    
    let animationView = LottieAnimationView()
    
    
    //MARK: - App Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        animateElements()
        startAnimation()
    }

    private func setupUI(){
        registerButton.layer.cornerRadius = 15
        loginButton.layer.cornerRadius = 15
        
        logoView.transform = CGAffineTransform(translationX: 0, y: 20)
        loginButton.transform = CGAffineTransform(translationX: 0, y: 20)
        registerButton.transform = CGAffineTransform(translationX: 0, y: 20)
        
        navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "Indietro", style: .plain, target: nil, action: nil)
    }
    
    //MARK: - IBActions
    @IBAction func handleCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func handleLoginButton(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "Login") as? LoginViewController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func handleRegisterButton(_ sender: UIButton) {
    }
    
    //MARK: - Animations
    private func animateElements(){
        let duration = 0.8
        let delayIncrement = 0.3

        titleLbl.text = ""
        var charIndex: Double = 0
        let titleText = "Chef Helper"
        
        for letter in titleText{
            Timer.scheduledTimer(withTimeInterval: 0.2 * charIndex, repeats: false) { _ in
                self.titleLbl.text?.append(letter)
            }
            charIndex += 1
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveEaseInOut], animations: {
            self.logoView.alpha = 1.0
            self.logoView.transform = .identity
        }, completion: nil)
        
        UIView.animate(withDuration: duration, delay: delayIncrement, options: [.curveEaseInOut], animations: {
            self.loginButton.alpha = 1.0
            self.loginButton.transform = .identity
        }, completion: nil)
        
        UIView.animate(withDuration: duration, delay: delayIncrement * 2, options: [.curveEaseInOut], animations: {
            self.registerButton.alpha = 1.0
            self.registerButton.transform = .identity
            self.registerButton.transform = .identity
            
        }, completion: nil)
        
    }
    
    private func startAnimation(){
        let animation = LottieAnimation.named("PersonCooking")
        
        animationView.animation = animation
        animationView.isUserInteractionEnabled = false
                    
        animationView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width-self.view.frame.width/5, height: 800)
        animationView.center = self.view.center
        
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.5
        animationView.play()
        self.view.addSubview(animationView)
        
        
    }
}
