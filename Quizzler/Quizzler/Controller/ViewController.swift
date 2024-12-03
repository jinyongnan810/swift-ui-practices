//
//  ViewController.swift
//  Quizzler
//
//  Created by Yuunan kin on 2024/12/03.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var trueButton: UIButton!
    @IBOutlet var falseButton: UIButton!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var questionText: UILabel!
    @IBOutlet var scoreLabel: UILabel!

    var quizBrain = QuizBrain()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func answerSelected(_ sender: UIButton) {
        let correct = quizBrain.checkAnswer(sender.currentTitle!)
        if correct {
            UIView.animate(withDuration: 0.2, animations: {
                sender.backgroundColor = UIColor.green
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                sender.backgroundColor = UIColor.red
            })
        }

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 0.5
        ) {
            self.quizBrain.nextQuestion()
            self.updateUI()
        }
    }

    private func updateUI() {
        UIView.animate(withDuration: 0.2, animations: {
            self.questionText.text = self.quizBrain.currentQuestionText()
            self.progressBar
                .setProgress(self.quizBrain.currentProgress(), animated: true)
            self.scoreLabel.text = "Score: \(self.quizBrain.score)"
            self.trueButton.backgroundColor = UIColor.clear
            self.falseButton.backgroundColor = UIColor.clear
        })
    }
}
