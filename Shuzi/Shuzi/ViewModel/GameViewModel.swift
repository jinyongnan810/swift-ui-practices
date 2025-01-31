//
//  GameViewModel.swift
//  Shuzi
//
//  Created by Yuunan kin on 2025/01/31.
//

import Observation
import AVFoundation

@Observable
final class GameViewModel {
    let synthesizer = AVSpeechSynthesizer()
    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.5
        utterance.volume = 0.6
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
        synthesizer.speak(utterance)
    }
}
