//
//  TypingModels.swift
//  SwiftUIPractices
//
//  Created by Yuunan kin on 2026/09/04.
//

import SwiftUI

// MARK: - Typing Speed Mode

enum TypingSpeedMode: String, CaseIterable, Identifiable {
    case fast = "Fast"
    case normal = "Normal"
    case slow = "Slow"
    case natural = "Natural"

    var id: String { rawValue }

    var baseDelayMs: UInt64 {
        switch self {
        case .fast: return 20
        case .normal: return 50
        case .slow: return 110
        case .natural: return 45
        }
    }

    var description: String {
        switch self {
        case .fast: return "20ms / char (Super fast)"
        case .normal: return "50ms / char (Standard speed)"
        case .slow: return "110ms / char (Deliberate pace)"
        case .natural: return "Human cadence with punctuation pauses"
        }
    }

    func delay(for character: Character) -> UInt64 {
        switch self {
        case .fast, .normal, .slow:
            return baseDelayMs
        case .natural:
            // Realistic punctuation pauses & slight human variation
            if character == "." || character == "!" || character == "?" {
                return 280
            } else if character == "," || character == ";" || character == ":" {
                return 160
            } else if character == "\n" {
                return 220
            } else {
                let jitter = Int.random(in: -12...22)
                let computed = Int(baseDelayMs) + jitter
                return UInt64(max(15, computed))
            }
        }
    }
}

// MARK: - Sound Effect (SE) Style

enum TypingSoundStyle: String, CaseIterable, Identifiable {
    case systemClick = "System Tock"
    case mechanical = "Mechanical"
    case softClick = "Soft Click"

    var id: String { rawValue }
}

// MARK: - Haptic Vibration Style

enum TypingHapticStyle: String, CaseIterable, Identifiable {
    case rigid = "Rigid Tap"
    case medium = "Medium"
    case strong = "Strong Pop"

    var id: String { rawValue }
}

// MARK: - Preset Samples

struct TypingSample: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let icon: String
    let text: String
}

let typingSamplePresets: [TypingSample] = [
    TypingSample(
        title: "Welcome",
        icon: "sparkles",
        text: """
        Welcome to SwiftUI Practices! 🚀
        This practice simulates a realistic typing event.
        Characters stream in sequentially, followed by a slowly blinking underscore cursor.
        """
    ),
    TypingSample(
        title: "Swift Code",
        icon: "chevron.left.forwardslash.chevron.right",
        text: """
        func typeWriterEffect(for text: String) async {
            for char in text {
                displayedText.append(char)
                try? await Task.sleep(for: .milliseconds(50))
            }
        }
        """
    ),
    TypingSample(
        title: "Quote",
        icon: "quote.opening",
        text: """
        "Simplicity is prerequisite for reliability."
        — Edsger W. Dijkstra
        """
    ),
    TypingSample(
        title: "Terminal",
        icon: "terminal",
        text: """
        [SYSTEM INITIALIZED]
        Scanning network nodes... 100%
        Status: READY.
        Type a command or enjoy the view.
        """
    ),
]
