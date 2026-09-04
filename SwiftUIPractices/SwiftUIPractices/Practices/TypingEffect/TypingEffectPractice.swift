//
//  TypingEffectPractice.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2026/09/04.
//

import SwiftUI

// MARK: - TypingEffectPractice View

struct TypingEffectPractice: View {
    // Current sample & content
    @State private var selectedSampleIndex: Int = 0
    @State private var customText: String = ""
    @State private var showCustomTextSheet: Bool = false
    @State private var showSettingsSheet: Bool = false

    // Typing State
    @State private var displayedText: String = ""
    @State private var isTyping: Bool = false
    @State private var isPaused: Bool = false
    @State private var typingTask: Task<Void, Never>?

    // Cursor Blink State (Slow organic breathing indicator)
    @State private var cursorOpacity: Double = 1.0
    @State private var blinkTask: Task<Void, Never>?

    // Configuration Settings (System Tock is default SE)
    @State private var speedMode: TypingSpeedMode = .natural
    @State private var enableSound: Bool = true
    @State private var soundStyle: TypingSoundStyle = .systemClick
    @State private var enableHaptics: Bool = true
    @State private var hapticStyle: TypingHapticStyle = .rigid

    // View-scoped audio/haptic feedback engine with automatic teardown on disappear
    @State private var feedbackEngine = TypingFeedbackEngine()

    private var activeFullText: String {
        if !customText.isEmpty {
            return customText
        }
        guard selectedSampleIndex < typingSamplePresets.count else { return "" }
        return typingSamplePresets[selectedSampleIndex].text
    }

    private var progressRatio: Double {
        let total = activeFullText.count
        guard total > 0 else { return 0 }
        return min(1.0, Double(displayedText.count) / Double(total))
    }

    var body: some View {
        // NavigationStack is provided by ContentView; only root ScrollView here
        ScrollView {
            VStack(spacing: 20) {
                // macOS-inspired Terminal Window Card
                TypingTerminalCard(
                    text: displayedText,
                    cursorOpacity: cursorOpacity,
                    isTyping: isTyping,
                    isPaused: isPaused
                )

                // Progress Bar
                progressSection

                // Quick Playback Action Buttons
                playbackControls

                // Sample Text Presets Selector
                sampleTextsSection
            }
            .padding()
        }
        .navigationTitle("Typing Effect")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    feedbackEngine.playButtonTap()
                    showSettingsSheet = true
                } label: {
                    Image(systemName: "gearshape")
                }
                .accessibilityLabel("Typing Settings")
            }
        }
        .onAppear {
            feedbackEngine.prepare()
            startTyping()
            startCursorAnimation()
        }
        .onDisappear {
            stopAllTasks()
            feedbackEngine.tearDown()
        }
        .sheet(isPresented: $showSettingsSheet) {
            TypingSettingsSheet(
                speedMode: $speedMode,
                enableSound: $enableSound,
                soundStyle: $soundStyle,
                enableHaptics: $enableHaptics,
                hapticStyle: $hapticStyle,
                feedbackEngine: feedbackEngine
            )
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $showCustomTextSheet) {
            customTextInputSheet
        }
    }

    // MARK: - Progress Section

    private var progressSection: some View {
        VStack(spacing: 6) {
            HStack {
                Text("Characters: \(displayedText.count) / \(activeFullText.count)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Spacer()
                Text("\(Int(progressRatio * 100))%")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.secondary)
            }

            ProgressView(value: progressRatio)
                .tint(.cyan)
        }
        .padding(.horizontal, 4)
    }

    // MARK: - Playback Controls

    private var playbackControls: some View {
        HStack(spacing: 12) {
            // Replay Button
            Button {
                feedbackEngine.playButtonTap()
                startTyping()
            } label: {
                Label("Restart", systemImage: "arrow.counterclockwise")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
            }
            .buttonStyle(.borderedProminent)
            .tint(.accentColor)

            // Pause / Resume Button
            Button {
                feedbackEngine.playButtonTap()
                if isPaused {
                    resumeTyping()
                } else if isTyping {
                    pauseTyping()
                } else {
                    startTyping()
                }
            } label: {
                Label(
                    isPaused ? "Resume" : (isTyping ? "Pause" : "Type"),
                    systemImage: isPaused ? "play.fill" : (isTyping ? "pause.fill" : "play.fill")
                )
                .font(.subheadline)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
            }
            .buttonStyle(.bordered)
            .disabled(!isTyping && !isPaused && displayedText == activeFullText)

            // Skip / Complete Immediately Button
            Button {
                feedbackEngine.playButtonTap()
                skipToEnd()
            } label: {
                Label("Skip", systemImage: "forward.end.fill")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
            }
            .buttonStyle(.bordered)
            .disabled(!isTyping && !isPaused)
        }
    }

    // MARK: - Sample Texts Section

    private var sampleTextsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Sample Texts")
                    .font(.headline)
                Spacer()
                Button {
                    feedbackEngine.playButtonTap()
                    showCustomTextSheet = true
                } label: {
                    Label("Custom Text", systemImage: "square.and.pencil")
                        .font(.caption)
                }
                .buttonStyle(.borderless)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(typingSamplePresets.indices, id: \.self) { index in
                        let sample = typingSamplePresets[index]
                        let isSelected = customText.isEmpty && selectedSampleIndex == index

                        Button {
                            feedbackEngine.playButtonTap()
                            customText = ""
                            selectedSampleIndex = index
                            startTyping()
                        } label: {
                            HStack(spacing: 6) {
                                Image(systemName: sample.icon)
                                Text(sample.title)
                            }
                            .font(.subheadline)
                            .fontWeight(isSelected ? .semibold : .regular)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(
                                Capsule().fill(
                                    isSelected
                                        ? Color.accentColor.opacity(0.15)
                                        : Color.primary.opacity(0.06)
                                )
                            )
                            .foregroundColor(isSelected ? .accentColor : .primary)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.vertical, 2)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.secondarySystemBackground))
        )
    }

    // MARK: - Custom Text Input Sheet

    private var customTextInputSheet: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 14) {
                Text("Enter any text to watch it typed character by character:")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                TextEditor(text: $customText)
                    .font(.system(.body, design: .monospaced))
                    .padding(8)
                    .background(Color(.tertiarySystemBackground))
                    .cornerRadius(10)
                    .frame(minHeight: 180)

                Spacer()
            }
            .padding()
            .navigationTitle("Custom Text")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        showCustomTextSheet = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Start Typing") {
                        showCustomTextSheet = false
                        startTyping()
                    }
                    .disabled(customText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }

    // MARK: - Typing Engine

    private func startTyping() {
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

                // Handle pause loop
                while isPaused {
                    if Task.isCancelled { break }
                    try? await Task.sleep(for: .milliseconds(100))
                }

                if Task.isCancelled { break }

                let char = characters[index]
                displayedText.append(char)

                // Play both Sound Effect (SE) and Haptic Vibration
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

    private func pauseTyping() {
        isPaused = true
    }

    private func resumeTyping() {
        isPaused = false
    }

    private func skipToEnd() {
        typingTask?.cancel()
        displayedText = activeFullText
        isTyping = false
        isPaused = false
    }

    // MARK: - Cursor Animation Engine

    /// Slowly blinking underscore typing indicator at the end of the text.
    /// Smooth organic sine-wave breathing oscillation with a ~1.2s period.
    private func startCursorAnimation() {
        blinkTask?.cancel()

        blinkTask = Task { @MainActor in
            var step: Double = 0
            while !Task.isCancelled {
                try? await Task.sleep(for: .milliseconds(33))
                if Task.isCancelled { break }
                step += 0.08
                let sine = sin(step)
                cursorOpacity = 0.05 + 0.95 * ((sine + 1.0) / 2.0)
            }
        }
    }

    private func stopAllTasks() {
        typingTask?.cancel()
        blinkTask?.cancel()
    }
}

// MARK: - Preview

#Preview {
    NavigationStack {
        TypingEffectPractice()
    }
}
