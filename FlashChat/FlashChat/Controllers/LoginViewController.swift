//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import FirebaseAuth
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextfield.delegate = self
        passwordTextfield.delegate = self
    }

    @IBAction func loginPressed(_: UIButton) {
        login()
    }

    private func login() {
        guard let email = emailTextfield.text, let password = passwordTextfield.text else {
            return
        }

        Auth
            .auth()
            .signIn(withEmail: email, password: password) {
                _,
                error in
                if let error {
                    print("Error signing in user: \(error.localizedDescription)")
                    self.showToast(message: error.localizedDescription)
                } else {
                    self.performSegue(
                        withIdentifier: K.loginToCHatSegue,
                        sender: self
                    )
                }
            }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextfield {
            passwordTextfield.becomeFirstResponder()
        } else {
            self.login()
        }
        return true
    }
}
