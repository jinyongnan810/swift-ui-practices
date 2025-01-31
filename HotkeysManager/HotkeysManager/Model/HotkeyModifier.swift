//
//  HotkeyModifier.swift
//  HotkeysManager
//
//  Created by Yuunan kin on 2025/01/30.
//

enum HotkeyModifier: String, CaseIterable {
    case control = "⌃"
    case option = "⌥"
    case shift = "⇧"
    case command = "⌘"
    case enter = "⏎" // "⌅" "⏎"
    case escape = "⎋"
    case globe = "🌐"

    var description: String {
        switch self {
        case .control:
            "ctrl"
        case .option:
            "alt"
        case .shift:
            "shift"
        case .command:
            "command"
        case .enter:
            "enter"
        case .escape:
            "escape"
        case .globe:
            "globe/fn"
        }
    }
}
