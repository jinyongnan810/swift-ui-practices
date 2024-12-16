//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import FirebaseAuth

class WelcomeViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        if Auth.auth().currentUser != nil {
            print("⭐️logged in as \(Auth.auth().currentUser!.email!)")
            self.titleLabel.text = K.appName
            if let viewController = storyboard?.instantiateViewController(withIdentifier: "ChatViewController") {
                navigationController?.pushViewController(viewController, animated: true)
            } else {
                print("Error: ViewController is nil")
            }
            return
        }
        print("⭐️not logged in")
        

        var charIndex = 0.0

        for char in K.appName {
            DispatchQueue.main
                .asyncAfter(deadline: .now() + 0.1 * charIndex) {
                    self.titleLabel.text?.append(char)
                }
//            Timer
//                .scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false, block: { timer in
//                    self.titleLabel.text?.append(char)
//
//            })
            charIndex += 1
        }
    }
}
