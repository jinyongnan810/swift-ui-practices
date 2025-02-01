//
//  SettingsView.swift
//  Shuzi
//
//  Created by Yuunan kin on 2025/02/01.
//

import SwiftUI

struct SettingsView: View {
    @Environment(GameViewModel.self) var viewModel
    var body: some View {
        @Bindable var bindableViewModel = viewModel
        GeometryReader { geometry in
            VStack {
                Text("Settings").padding(.vertical)
                
                Text("Volume: \(bindableViewModel.game.volume)")
                Slider(value: $bindableViewModel.game.volume) {
                    Text("Volume")
                }
                
                Toggle(
                    "Show Pinyin",
                    isOn: $bindableViewModel.game.showPinyin.animation()
                )
                Spacer()
            }.frame(maxHeight: geometry.size.height/2)
                .padding()

        }
    }
}

#Preview {
    SettingsView()
}
