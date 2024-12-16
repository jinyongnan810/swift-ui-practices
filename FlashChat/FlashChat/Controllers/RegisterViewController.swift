//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import FirebaseAuth
import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextfield.delegate = self
        passwordTextfield.delegate = self
    }

    @IBAction func registerPressed(_: UIButton) {
        signup()
    }

    private func signup() {
        guard let email = emailTextfield.text, let password = passwordTextfield.text else {
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) {
            _,
            error in
            if let error {
                print("Error creating user: \(error.localizedDescription)")
                self.showToast(message: error.localizedDescription)
            } else {
                self.performSegue(
                    withIdentifier: K.registerToChatSegue,
                    sender: self
                )
            }
        }
    }

    
}

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextfield {
            passwordTextfield.becomeFirstResponder()
        } else {
            self.signup()
        }
        return true
    }
}
