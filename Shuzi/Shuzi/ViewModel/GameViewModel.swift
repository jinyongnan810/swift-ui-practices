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

@Observable
final class GameViewModel {
    var game = GameModel()
    let synthesizer = AVSpeechSynthesizer()
    var audioPlayer: AVAudioPlayer?
    init() {
        game.generateNewTurn()
        speak(text: String(game.answer))
    }

    func selectAnswer(_ number: Int) {
        let correct = number == game.answer
        if correct {
            playSuccessSound()
            game.incrementScore()
        } else {
            playFailSound()
        }
        game.incrementTurn()
        if game.maxTurns <= game.currentTurn {
            // game end
            return
        }

        game.generateNewTurn()
        speak(text: String(game.answer))
    }

    func reset() {
        game.reset()
        speak(text: String(game.answer))
    }

    func speak(text: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let utterance = AVSpeechUtterance(string: text)
            utterance.rate = 0.5
            utterance.volume = self.game.volume
            utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
            self.synthesizer.speak(utterance)
        }

    }

    private func playSound(name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "aiff") else { return }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.prepareToPlay()
            audioPlayer?.volume = game.volume
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
