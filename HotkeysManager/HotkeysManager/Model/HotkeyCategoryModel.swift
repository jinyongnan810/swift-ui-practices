//
//  HotkeyCategory.swift
//  HotkeysManager
//
//  Created by Yuunan kin on 2025/01/30.
//
import Foundation

struct HotkeyCategoryModel: Identifiable {
    let id: UUID = .init()
    let name: String
    let hotkeys: [HotkeyModel]
}
