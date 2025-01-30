//
//  HotkeyModel.swift
//  HotkeysManager
//
//  Created by Yuunan kin on 2025/01/30.
//
import Foundation

struct HotkeyModel: Identifiable {
    let id: UUID = .init()
    let modifiers: [HotkeyModifier]
    let character: String
    let text: String

    var description: String {
        "\(modifiers.map(\.rawValue).joined(separator: " ")) \(character)"
    }
}
