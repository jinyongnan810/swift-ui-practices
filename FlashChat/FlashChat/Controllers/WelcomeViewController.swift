//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!

    let titleText = "⚡️FlashChat"

    override func viewDidLoad() {
        super.viewDidLoad()

        var charIndex = 0.0

        for char in titleText {
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
