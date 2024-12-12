//
//  RegisterViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!

    @IBAction func registerPressed(_: UIButton) {
        guard let email = emailTextfield.text, let password = passwordTextfield.text else {
            return
        }

        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error creating user: \(error.localizedDescription)")
                self.showToast(message: error.localizedDescription)
            } else {
                self.performSegue(withIdentifier: "RegisterToChat", sender: self)
            }

        }
    }
}
