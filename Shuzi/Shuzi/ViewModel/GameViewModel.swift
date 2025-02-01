//
//  GameViewModel.swift
//  Shuzi
//
//  Created by Yuunan kin on 2025/01/31.
//

import AVFoundation
import Observation

let successSounds: [String] = ["awesome", "bell", "correct", "whoop", "yes"]
let failSounds: [String] = ["incorrectAnswer", "OhNo", "weak"]
let digitMap: [Int: String] = [
    0: "零", 1: "一", 2: "二", 3: "三", 4: "四", 5: "五", 6: "六", 7: "七", 8: "八", 9: "九",
    10: "十",
]

@Observable
final class GameViewModel {
    var gameModel = GameModel()
    let synthesizer = AVSpeechSynthesizer()
    var audioPlayer: AVAudioPlayer?

    func numberToShuzi(_ number: Int) -> String {
        switch number {
        case 0 ... 10:
            return digitMap[number] ?? ""
        case 11 ... 19:
            let unit = number % 10
            return "十" + (digitMap[unit] ?? "")
        case 20 ... 99:
            let tenth = number / 10
            if number % 10 == 0 {
                return (digitMap[tenth] ?? "") + "十"
            }
            let unit = number % 10
            return (digitMap[tenth] ?? "") + "十" + (digitMap[unit] ?? "")
        default:
            return ""
        }
    }

    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.5
        utterance.volume = 0.6
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
        synthesizer.speak(utterance)
    }

    private func playSound(name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "aiff") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.volume = gameModel.volume
            audioPlayer?.play()
        } catch {
            print("⭐️ Error playing sound: \(error.localizedDescription)")
        }
    }

    func playSuccessSound() {
        playSound(name: successSounds.randomElement() ?? successSounds.first!)
    }

    func playFailSound() {
        playSound(name: failSounds.randomElement() ?? failSounds.first!)
    }
}
