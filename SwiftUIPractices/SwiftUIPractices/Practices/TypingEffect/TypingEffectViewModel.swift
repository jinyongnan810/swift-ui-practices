//
//  TypingEffectViewModel.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2026/09/05.
//

import SwiftUI

// MARK: - Typing Effect ViewModel

@Observable
@MainActor
final class TypingEffectViewModel {
    // Content & Presets
    var selectedSampleIndex: Int = 0
    var customText: String = ""
    var showCustomTextSheet: Bool = false
    var showSettingsSheet: Bool = false

    // Typing Execution State
    var displayedText: String = ""
    var isTyping: Bool = false
    var isPaused: Bool = false

    // Configuration Settings (System Tock is default SE)
    var speedMode: TypingSpeedMode = .natural
    var enableSound: Bool = true
    var soundStyle: TypingSoundStyle = .systemClick
    var enableHaptics: Bool = true
    var hapticStyle: TypingHapticStyle = .rigid

    // View-scoped audio/haptic feedback engine
    let feedbackEngine = TypingFeedbackEngine()

    private var typingTask: Task<Void, Never>?

    // MARK: - Computed Properties

    var activeFullText: String {
        if !customText.isEmpty {
            return customText
        }
        guard selectedSampleIndex < typingSamplePresets.count else { return "" }
        return typingSamplePresets[selectedSampleIndex].text
    }

    var progressRatio: Double {
        let total = activeFullText.count
        guard total > 0 else { return 0 }
        return min(1.0, Double(displayedText.count) / Double(total))
    }

    var isCompleted: Bool {
        !isTyping && !isPaused && displayedText == activeFullText
    }

    // MARK: - Lifecycle

    func onAppear() {
        feedbackEngine.prepare()
        startTyping()
    }

    func onDisappear() {
        stopTyping()
        feedbackEngine.tearDown()
    }

    // MARK: - Playback Actions

    func selectSample(at index: Int) {
        feedbackEngine.playButtonTap()
        customText = ""
        selectedSampleIndex = index
        startTyping()
    }

    func submitCustomText(_ text: String) {
        customText = text
        startTyping()
    }

    func startTyping() {
        typingTask?.cancel()
        displayedText = ""
        isTyping = true
        isPaused = false

        let targetText = activeFullText
        let characters = Array(targetText)

        feedbackEngine.prepare()

        typingTask = Task { @MainActor in
            for index in characters.indices {
                if Task.isCancelled { break }

                // Pause loop
                while isPaused {
                    if Task.isCancelled { break }
                    try? await Task.sleep(for: .milliseconds(100))
                }

                if Task.isCancelled { break }

                let char = characters[index]
                displayedText.append(char)

                // Sound Effect (SE) & Haptic Vibration
                feedbackEngine.playKeystroke(
                    soundEnabled: enableSound,
                    soundStyle: soundStyle,
                    hapticEnabled: enableHaptics,
                    hapticStyle: hapticStyle
                )

                let sleepDelay = speedMode.delay(for: char)
                try? await Task.sleep(for: .milliseconds(sleepDelay))
            }

            if !Task.isCancelled {
                isTyping = false
                isPaused = false
            }
        }
    }

    func pauseTyping() {
        feedbackEngine.playButtonTap()
        isPaused = true
    }

    func resumeTyping() {
        feedbackEngine.playButtonTap()
        isPaused = false
    }

    func restartTyping() {
        feedbackEngine.playButtonTap()
        startTyping()
    }

    func skipToEnd() {
        feedbackEngine.playButtonTap()
        typingTask?.cancel()
        displayedText = activeFullText
        isTyping = false
        isPaused = false
    }

    func stopTyping() {
        typingTask?.cancel()
    }
}
