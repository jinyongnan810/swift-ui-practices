//
//  TypingFeedbackEngine.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2026/09/04.
//

import SwiftUI
import AudioToolbox
import AVFoundation
import CoreHaptics

// MARK: - Typing Feedback Engine (Sound Effects & Vibration)

@MainActor
final class TypingFeedbackEngine {
    // Audio players pool for rapid keystroke sound effect playback
    private var mechanicalPlayers: [AVAudioPlayer] = []
    private var softPlayers: [AVAudioPlayer] = []
    private var playerIndex: Int = 0

    // CoreHaptics engine for fine-grained hardware tactile feedback
    private var hapticEngine: CHHapticEngine?

    init() {
        configureAudioSession()
        prepareAudioPlayers()
        setupCoreHaptics()
    }

    deinit {
        hapticEngine?.stop()
    }

    private var isAudioSessionConfigured: Bool = false

    /// Releases resources (stops haptic engine and audio players) when view goes down
    func tearDown() {
        hapticEngine?.stop()
        for player in mechanicalPlayers {
            player.stop()
        }
        for player in softPlayers {
            player.stop()
        }
        mechanicalPlayers.removeAll()
        softPlayers.removeAll()
        isAudioSessionConfigured = false
        isAudioPlayersPrepared = false
        #if canImport(AVFoundation) && os(iOS)
        // Deactivate audio session on a background task to prevent main-thread hangs
        Task.detached(priority: .utility) {
            try? AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
        }
        #endif
    }

    private func configureAudioSession() {
        #if canImport(AVFoundation) && os(iOS)
        guard !isAudioSessionConfigured else { return }
        isAudioSessionConfigured = true

        // Configure and activate audio session off the main thread to prevent UI hang risk
        Task.detached(priority: .userInitiated) {
            do {
                let session = AVAudioSession.sharedInstance()
                try session.setCategory(.playback, options: [.mixWithOthers])
                try session.setActive(true)
            } catch {
                print("Failed to configure AVAudioSession asynchronously: \(error)")
            }
        }
        #endif
    }

    private var isAudioPlayersPrepared: Bool = false

    private func prepareAudioPlayers() {
        guard !isAudioPlayersPrepared else { return }
        isAudioPlayersPrepared = true

        // Move audio data synthesis and player.prepareToPlay() off the main thread to eliminate hang risks
        Task.detached(priority: .utility) {
            let poolSize = 4

            let mechanicalData = Self.createClickWAVData(frequency: 1900, duration: 0.032, noiseWeight: 0.5)
            let softData = Self.createClickWAVData(frequency: 850, duration: 0.025, noiseWeight: 0.2)

            let mPlayers = (0..<poolSize).compactMap { _ in
                try? AVAudioPlayer(data: mechanicalData)
            }
            for player in mPlayers {
                player.volume = 0.85
                player.prepareToPlay()
            }

            let sPlayers = (0..<poolSize).compactMap { _ in
                try? AVAudioPlayer(data: softData)
            }
            for player in sPlayers {
                player.volume = 0.75
                player.prepareToPlay()
            }

            await MainActor.run { [weak self] in
                self?.mechanicalPlayers = mPlayers
                self?.softPlayers = sPlayers
            }
        }
    }

    func prepare() {
        configureAudioSession()
        if hapticEngine == nil {
            setupCoreHaptics()
        } else {
            try? hapticEngine?.start()
        }
    }

    private func setupCoreHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        do {
            hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
            hapticEngine?.resetHandler = { [weak self] in
                try? self?.hapticEngine?.start()
            }
        } catch {
            print("CoreHaptics init error: \(error)")
        }
    }

    @discardableResult
    private func triggerCoreHaptic(intensity: Float, sharpness: Float) -> Bool {
        guard let engine = hapticEngine else { return false }
        let intensityParam = CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity)
        let sharpnessParam = CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensityParam, sharpnessParam], relativeTime: 0)
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: CHHapticTimeImmediate)
            return true
        } catch {
            return false
        }
    }

    func playKeystroke(
        soundEnabled: Bool,
        soundStyle: TypingSoundStyle,
        hapticEnabled: Bool,
        hapticStyle: TypingHapticStyle
    ) {
        // 1. Trigger Sound Effect (SE)
        if soundEnabled {
            switch soundStyle {
            case .systemClick:
                // Standard iOS keyboard click sound (SystemSoundID 1104)
                AudioServicesPlaySystemSound(1104)
            case .mechanical:
                if !mechanicalPlayers.isEmpty {
                    let player = mechanicalPlayers[playerIndex % mechanicalPlayers.count]
                    player.currentTime = 0
                    player.play()
                }
            case .softClick:
                if !softPlayers.isEmpty {
                    let player = softPlayers[playerIndex % softPlayers.count]
                    player.currentTime = 0
                    player.play()
                }
            }
            playerIndex &+= 1
        }

        // 2. Trigger Haptic Vibration
        if hapticEnabled {
            var coreHapticSuccess = false
            switch hapticStyle {
            case .rigid:
                coreHapticSuccess = triggerCoreHaptic(intensity: 1.0, sharpness: 1.0)
            case .medium:
                coreHapticSuccess = triggerCoreHaptic(intensity: 0.65, sharpness: 0.5)
            case .strong:
                coreHapticSuccess = triggerCoreHaptic(intensity: 1.0, sharpness: 0.75)
            }

            // Fallback to direct hardware system vibration only if CoreHaptics is unavailable
            if !coreHapticSuccess {
                switch hapticStyle {
                case .rigid, .medium:
                    AudioServicesPlaySystemSound(1519) // Peek
                case .strong:
                    AudioServicesPlaySystemSound(1520) // Pop
                }
            }
        }
    }

    func playButtonTap() {
        if !triggerCoreHaptic(intensity: 0.5, sharpness: 0.5) {
            AudioServicesPlaySystemSound(1519)
        }
        AudioServicesPlaySystemSound(1104)
    }

    // MARK: - In-Memory Click WAV Synthesizer

    nonisolated private static func createClickWAVData(frequency: Float, duration: Float, noiseWeight: Float) -> Data {
        let sampleRate = 44100
        let numSamples = Int(Float(sampleRate) * duration)
        var data = Data()

        // RIFF header
        data.append(contentsOf: "RIFF".utf8)
        let chunkSize = UInt32(36 + numSamples * 2)
        data.append(contentsOf: withUnsafeBytes(of: chunkSize.littleEndian) { Array($0) })
        data.append(contentsOf: "WAVE".utf8)

        // fmt chunk
        data.append(contentsOf: "fmt ".utf8)
        let subchunk1Size: UInt32 = 16
        data.append(contentsOf: withUnsafeBytes(of: subchunk1Size.littleEndian) { Array($0) })
        let audioFormat: UInt16 = 1 // PCM
        data.append(contentsOf: withUnsafeBytes(of: audioFormat.littleEndian) { Array($0) })
        let numChannels: UInt16 = 1 // Mono
        data.append(contentsOf: withUnsafeBytes(of: numChannels.littleEndian) { Array($0) })
        let sampleRateU32 = UInt32(sampleRate)
        data.append(contentsOf: withUnsafeBytes(of: sampleRateU32.littleEndian) { Array($0) })
        let byteRate = UInt32(sampleRate * 2)
        data.append(contentsOf: withUnsafeBytes(of: byteRate.littleEndian) { Array($0) })
        let blockAlign: UInt16 = 2
        data.append(contentsOf: withUnsafeBytes(of: blockAlign.littleEndian) { Array($0) })
        let bitsPerSample: UInt16 = 16
        data.append(contentsOf: withUnsafeBytes(of: bitsPerSample.littleEndian) { Array($0) })

        // data chunk
        data.append(contentsOf: "data".utf8)
        let dataSize = UInt32(numSamples * 2)
        data.append(contentsOf: withUnsafeBytes(of: dataSize.littleEndian) { Array($0) })

        // Generate synthetic mechanical click pulse
        for i in 0..<numSamples {
            let t = Float(i) / Float(sampleRate)
            let decay = exp(-t * 110.0)
            let noise = Float.random(in: -1...1) * exp(-t * 300.0) * noiseWeight
            let tone = sin(2.0 * .pi * frequency * t) * (1.0 - noiseWeight)
            let sampleVal = (tone + noise) * decay
            let clamped = max(-1.0, min(1.0, sampleVal))
            let int16Val = Int16(clamped * 32767.0)
            data.append(contentsOf: withUnsafeBytes(of: int16Val.littleEndian) { Array($0) })
        }

        return data
    }
}
