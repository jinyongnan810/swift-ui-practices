//
//  TypingEffectPractice.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2026/09/04.
//

import SwiftUI

// MARK: - TypingEffectPractice View

struct TypingEffectPractice: View {
    @State private var viewModel = TypingEffectViewModel()
    @State private var draftCustomText: String = ""

    var body: some View {
        // NavigationStack is provided by ContentView; only root ScrollView here
        ScrollView {
            VStack(spacing: 20) {
                // macOS-inspired Terminal Window Card (no longer receives cursorOpacity)
                TypingTerminalCard(
                    text: viewModel.displayedText,
                    isTyping: viewModel.isTyping,
                    isPaused: viewModel.isPaused
                )

                // Progress Bar (updates only when progress/displayed count changes)
                TypingProgressBar(
                    displayedCount: viewModel.displayedText.count,
                    totalCount: viewModel.activeFullText.count,
                    progressRatio: viewModel.progressRatio
                )

                // Quick Playback Action Buttons (updates only when isTyping, isPaused, isCompleted change)
                TypingPlaybackControls(viewModel: viewModel)

                // Sample Text Presets Selector (updates only when preset selection changes)
                TypingPresetSelector(
                    viewModel: viewModel,
                    onOpenCustomText: {
                        draftCustomText = viewModel.customText
                        viewModel.showCustomTextSheet = true
                    }
                )
            }
            .padding()
        }
        .navigationTitle("Typing Effect")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.feedbackEngine.playButtonTap()
                    viewModel.showSettingsSheet = true
                } label: {
                    Image(systemName: "gearshape")
                }
                .accessibilityLabel("Typing Settings")
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .onDisappear {
            viewModel.onDisappear()
        }
        .sheet(isPresented: $viewModel.showSettingsSheet) {
            TypingSettingsSheet(
                speedMode: $viewModel.speedMode,
                enableSound: $viewModel.enableSound,
                soundStyle: $viewModel.soundStyle,
                enableHaptics: $viewModel.enableHaptics,
                hapticStyle: $viewModel.hapticStyle,
                feedbackEngine: viewModel.feedbackEngine
            )
            .presentationDetents([.medium, .large])
            .presentationDragIndicator(.visible)
        }
        .sheet(isPresented: $viewModel.showCustomTextSheet) {
            customTextInputSheet
        }
    }

    // MARK: - Custom Text Input Sheet

    private var customTextInputSheet: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 14) {
                Text("Enter any text to watch it typed character by character:")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                TextEditor(text: $draftCustomText)
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
                        viewModel.showCustomTextSheet = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Start Typing") {
                        viewModel.showCustomTextSheet = false
                        viewModel.submitCustomText(draftCustomText)
                    }
                    .disabled(draftCustomText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

// MARK: - Progress Section

private struct TypingProgressBar: View {
    let displayedCount: Int
    let totalCount: Int
    let progressRatio: Double

    var body: some View {
        VStack(spacing: 6) {
            HStack {
                Text("Characters: \(displayedCount) / \(totalCount)")
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
}

// MARK: - Playback Controls

private struct TypingPlaybackControls: View {
    let viewModel: TypingEffectViewModel

    var body: some View {
        HStack(spacing: 12) {
            // Replay Button
            Button {
                viewModel.restartTyping()
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
                if viewModel.isPaused {
                    viewModel.resumeTyping()
                } else if viewModel.isTyping {
                    viewModel.pauseTyping()
                } else {
                    viewModel.startTyping()
                }
            } label: {
                Label(
                    viewModel.isPaused ? "Resume" : (viewModel.isTyping ? "Pause" : "Type"),
                    systemImage: viewModel.isPaused ? "play.fill" : (viewModel.isTyping ? "pause.fill" : "play.fill")
                )
                .font(.subheadline)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
            }
            .buttonStyle(.bordered)
            .disabled(viewModel.isCompleted)

            // Skip Button
            Button {
                viewModel.skipToEnd()
            } label: {
                Label("Skip", systemImage: "forward.end.fill")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
            }
            .buttonStyle(.bordered)
            .disabled(!viewModel.isTyping && !viewModel.isPaused)
        }
    }
}

// MARK: - Sample Text Presets Selector

private struct TypingPresetSelector: View {
    let viewModel: TypingEffectViewModel
    let onOpenCustomText: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Sample Texts")
                    .font(.headline)
                Spacer()
                Button {
                    viewModel.feedbackEngine.playButtonTap()
                    onOpenCustomText()
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
                        let isSelected = viewModel.customText.isEmpty && viewModel.selectedSampleIndex == index

                        Button {
                            viewModel.selectSample(at: index)
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
}

// MARK: - Preview

#Preview {
    NavigationStack {
        TypingEffectPractice()
    }
}
