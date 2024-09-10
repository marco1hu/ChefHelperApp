//
//  AuthorisationViewController.swift
//  ChefHelperApp
//
//  Created by IFTS40 on 01/09/24.
//

import UIKit

class AuthorisationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
        
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var logoView: UIImageView!

    @IBAction func handleCancel(_ sender: Any) {
        self.dismiss(animated: true)
    }
}
