//
//  ViewController.swift
//  Dicee
//
//  Created by Yuunan kin on 2024/11/30.
//

import UIKit

let diceImageNames: [String] = [
    "DiceOne", "DiceTwo", "DiceThree", "DiceFour", "DiceFive", "DiceSix",
]
let diceImages: [UIImage] = diceImageNames.map { name in
    UIImage(named: name)!
}

class ViewController: UIViewController {
    @IBOutlet var diceImageView1: UIImageView!
    @IBOutlet var diceImageView2: UIImageView!
    var currentDiceNumber1 = 0
    var currentDiceNumber2 = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        rollDice()
    }

    @IBAction func rollButton(_: Any) {
        let rollCount = Int.random(in: 9 ... 15)
        print(rollCount)
        rollDiceWithDelay(rollCount: rollCount, currentCount: 0)
    }

    private func rollDiceWithDelay(rollCount: Int, currentCount: Int) {
        guard currentCount < rollCount else { return }

        print("rolling...")
        rollDice()

        DispatchQueue.main.asyncAfter(
            deadline: .now() + (0.12 + 0.03 * Double(currentCount))
        ) {
            self.rollDiceWithDelay(
                rollCount: rollCount, currentCount: currentCount + 1
            )
        }
    }

    private func rollDice() {
        var random1 = Int.random(in: 0 ... 5)
        while random1 == currentDiceNumber1 {
            random1 = Int.random(in: 0 ... 5)
        }
        diceImageView1.image = diceImages[random1]
        currentDiceNumber1 = random1

        var random2 = Int.random(in: 0 ... 5)
        while random2 == currentDiceNumber2 {
            random2 = Int.random(in: 0 ... 5)
        }
        diceImageView2.image = diceImages[random2]
        currentDiceNumber2 = random2
    }
}
