//
//  HotkeyView.swift
//  HotkeysManager
//
//  Created by Yuunan kin on 2025/01/30.
//

import SwiftUI

struct HotkeyView: View {
    let hotkey: HotkeyModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(hotkey.text)
                .font(.caption)
            Text(hotkey.description)
                .font(.caption)

        }
    }
}

#Preview {
    HotkeyView(
        hotkey: .init(modifiers: [.command, .shift], character: "K", text: "Clean Build Folder")
    )
}
