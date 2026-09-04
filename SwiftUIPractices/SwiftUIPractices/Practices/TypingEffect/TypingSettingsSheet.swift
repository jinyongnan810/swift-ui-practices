//
//  TypingSettingsSheet.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2026/09/04.
//

import SwiftUI

// MARK: - Typing Settings Bottom Sheet

struct TypingSettingsSheet: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var speedMode: TypingSpeedMode
    @Binding var enableSound: Bool
    @Binding var soundStyle: TypingSoundStyle
    @Binding var enableHaptics: Bool
    @Binding var hapticStyle: TypingHapticStyle

    let feedbackEngine: TypingFeedbackEngine

    var body: some View {
        NavigationStack {
            Form {
                // Typing Speed Section
                Section {
                    Picker("Speed", selection: $speedMode) {
                        ForEach(TypingSpeedMode.allCases) { mode in
                            Text(mode.rawValue).tag(mode)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Typing Speed")
                } footer: {
                    Text(speedMode.description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                // Sound Effects (SE) Section
                Section {
                    Toggle(isOn: $enableSound) {
                        Label("Sound Effect (SE)", systemImage: "speaker.wave.2")
                    }

                    if enableSound {
                        Picker("Sound Style", selection: $soundStyle) {
                            ForEach(TypingSoundStyle.allCases) { style in
                                Text(style.rawValue).tag(style)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                } header: {
                    Text("Sound Effects (SE)")
                } footer: {
                    Text("Plays keystroke clicks through speakers, even when muted.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                // Haptic Vibration Section
                Section {
                    Toggle(isOn: $enableHaptics) {
                        Label("Haptic Vibration", systemImage: "iphone.radiowaves.left.and.right")
                    }

                    if enableHaptics {
                        Picker("Haptic Style", selection: $hapticStyle) {
                            ForEach(TypingHapticStyle.allCases) { style in
                                Text(style.rawValue).tag(style)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                } header: {
                    Text("Haptic Feedback")
                } footer: {
                    Text("Powered by CoreHaptics for fine-tuned tactile response.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }

                // Test Feedback Action Section
                Section {
                    Button {
                        feedbackEngine.playKeystroke(
                            soundEnabled: enableSound,
                            soundStyle: soundStyle,
                            hapticEnabled: enableHaptics,
                            hapticStyle: hapticStyle
                        )
                    } label: {
                        Label("Test Sound & Haptic", systemImage: "speaker.wave.2.bubble.left.fill")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .fontWeight(.medium)
                    }
                }
            }
            .navigationTitle("Typing Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

// MARK: - Preview

#Preview {
    TypingSettingsSheet(
        speedMode: .constant(.natural),
        enableSound: .constant(true),
        soundStyle: .constant(.systemClick),
        enableHaptics: .constant(true),
        hapticStyle: .constant(.rigid),
        feedbackEngine: TypingFeedbackEngine()
    )
}
