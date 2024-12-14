//
//  LoginViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!

    @IBAction func loginPressed(_: UIButton) {
        guard let email = emailTextfield.text, let password = passwordTextfield.text else {
            return
        }

        Auth
            .auth()
            .signIn(withEmail: email, password: password) {
 result,
 error in
            if let error = error {
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
