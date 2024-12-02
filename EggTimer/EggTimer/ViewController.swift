//
//  ViewController.swift
//  EggTimer
//
//  Created by Yuunan kin on 2024/12/02.
//

import UIKit

class ViewController: UIViewController {
    var timer: Timer?
    var elapsedTime: Int = 0
    var totalTime: Int = 0

    let boilTime: [String: Int] = [
        "Soft": 300,
        "Medium": 420,
        "Hard": 720,
    ]

    @IBOutlet var progressBar: UIProgressView!

    @IBAction func onPressed(_ sender: UIButton) {
        let hardness = sender.currentTitle!
        let time = boilTime[hardness] ?? 0
        elapsedTime = 0
        totalTime = time
        print(time)
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
    }

    @objc func timerFired() {
        elapsedTime += 1
        let progress = Float(elapsedTime) / Float(totalTime)
        UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) {
            self.progressBar.setProgress(progress, animated: true)
        }
        print("elapsed time: \(elapsedTime)")
        if elapsedTime >= totalTime {
            stopTimer()
            let alert = UIAlertController(
                title: "Done",
                message: "Your egg is ready!",
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
    }

    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
}
