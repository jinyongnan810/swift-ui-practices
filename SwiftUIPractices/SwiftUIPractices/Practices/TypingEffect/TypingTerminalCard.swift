//
//  TypingTerminalCard.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2026/09/04.
//

import SwiftUI

// MARK: - Terminal Card

struct TypingTerminalCard: View {
    let text: String
    let isTyping: Bool
    let isPaused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Window Header Bar
            HStack(spacing: 8) {
                // Traffic light dots
                Circle().fill(Color.red.opacity(0.85)).frame(width: 12, height: 12)
                Circle().fill(Color.yellow.opacity(0.85)).frame(width: 12, height: 12)
                Circle().fill(Color.green.opacity(0.85)).frame(width: 12, height: 12)

                Spacer()

                // Window Title
                Text("typing-stream.swift")
                    .font(.system(.caption2, design: .monospaced))
                    .foregroundColor(.secondary)

                Spacer()

                // Status Pill
                statusBadge
            }
            .padding(.bottom, 6)

            Divider()

            // Isolated Text Content Area with self-contained cursor animation
            TypingTextStreamView(text: text, isTyping: isTyping)
        }
        .padding(18)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.secondarySystemBackground))
                .shadow(color: .black.opacity(0.08), radius: 10, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.primary.opacity(0.08), lineWidth: 1)
        )
    }

    // MARK: - Status Badge

    private var statusBadge: some View {
        HStack(spacing: 5) {
            if isTyping && !isPaused {
                Circle()
                    .fill(Color.green)
                    .frame(width: 6, height: 6)
                Text("Typing...")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
            } else if isPaused {
                Circle()
                    .fill(Color.orange)
                    .frame(width: 6, height: 6)
                Text("Paused")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundColor(.orange)
            } else {
                Circle()
                    .fill(Color.secondary)
                    .frame(width: 6, height: 6)
                Text("Completed")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            Capsule()
                .fill(Color.primary.opacity(0.05))
        )
    }
}

// MARK: - Isolated Typing Text Stream View

/// Container for the text area. The visible text is completely static and
/// only re-renders when characters change. The indicator is an isolated subview.
struct TypingTextStreamView: View {
    let text: String
    let isTyping: Bool

    var body: some View {
        ZStack(alignment: .topLeading) {
            // Invisible placeholder to reserve minimal vertical size
            Text(" ")
                .font(.system(.body, design: .monospaced))
                .frame(minHeight: 140, alignment: .topLeading)

            // 1. Primary Visible Text
            // Only re-renders when `text` changes (when characters stream in).
            // It never re-renders on cursor blink ticks!
            Text(text)
                .font(.system(.body, design: .monospaced))
                .foregroundColor(.primary)

            // 2. Isolated Indicator
            // Only this view handles blinking. Driven by CoreAnimation on the GPU.
            TypingCursorIndicator(text: text, isTyping: isTyping)
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .textSelection(.enabled)
    }
}

// MARK: - Isolated Cursor Indicator

/// Isolated cursor indicator.
/// Positions the underscore immediately following the last glyph using clear text metrics,
/// and animates via CoreAnimation with 0 CPU timer overhead and zero text re-renders.
struct TypingCursorIndicator: View {
    let text: String
    let isTyping: Bool

    @State private var isBlinking: Bool = false

    var body: some View {
        Text("\(Text(text).foregroundColor(.clear))\(Text("_").fontWeight(.bold).foregroundColor(Color.cyan))")
            .font(.system(.body, design: .monospaced))
            .opacity(isTyping ? 1.0 : (isBlinking ? 0.08 : 1.0))
            .animation(
                isTyping
                    ? .none
                    : .easeInOut(duration: 0.6).repeatForever(autoreverses: true),
                value: isBlinking
            )
            .onAppear {
                if !isTyping {
                    isBlinking = true
                }
            }
            .onChange(of: isTyping) { _, typing in
                if !typing {
                    isBlinking = true
                } else {
                    isBlinking = false
                }
            }
            .allowsHitTesting(false)
            .accessibilityHidden(true)
    }
}
