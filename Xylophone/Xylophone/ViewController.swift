//
//  ViewController.swift
//  Xylophone
//
//  Created by Yuunan kin on 2024/12/01.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    var audioPlayer: AVAudioPlayer?
    let fileNames = ["C", "D", "E", "F", "G", "A", "B"]
    var fileUrls: [String: URL] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
        try? AVAudioSession.sharedInstance().setActive(true)
        for fileName in fileNames {
            fileUrls[fileName] = (Bundle.main.url(forResource: fileName, withExtension: "wav")!)
        }
    }

    @IBAction func keyPressed(_ sender: UIButton) {
        let bgColor = sender.backgroundColor
        UIView.animate(withDuration: 0.2) {
            sender.backgroundColor = bgColor?.withAlphaComponent(0.5)
        }
        playSound(sender.currentTitle ?? "C")
        UIView.animate(withDuration: 0.2) {
            sender.backgroundColor = bgColor
        }
    }

    private func playSound(_ name: String) {
        guard let url = fileUrls[name] else { return }

        do {
            audioPlayer = try AVAudioPlayer(
                contentsOf: url,
                fileTypeHint: AVFileType
                    .wav.rawValue
            )
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}
