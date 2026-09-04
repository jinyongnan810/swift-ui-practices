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
    let cursorOpacity: Double
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

            // Typing Text Content Area with slowly blinking underscore
            ZStack(alignment: .topLeading) {
                // Invisible placeholder to reserve minimal vertical size
                Text(" ")
                    .font(.system(.body, design: .monospaced))
                    .frame(minHeight: 140, alignment: .topLeading)

                Text(text)
                    .font(.system(.body, design: .monospaced))
                    .foregroundColor(.primary)
                + Text("_")
                    .font(.system(.body, design: .monospaced))
                    .fontWeight(.bold)
                    .foregroundColor(Color.cyan.opacity(cursorOpacity))
            }
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .textSelection(.enabled)
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
