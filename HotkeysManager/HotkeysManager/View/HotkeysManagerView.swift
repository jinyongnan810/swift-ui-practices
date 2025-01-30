//
//  HotkeysManagerView.swift
//  HotkeysManager
//
//  Created by Yuunan kin on 2025/01/30.
//

import SwiftUI

struct HotkeysManagerView: View {
    @State private var viewModel: HotkeyCategoryViewModel = .init()
    @State private var query = ""
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.categories) { category in
                    Section(category.name) {
                        ForEach(category.hotkeys) { hotkey in
                            HotkeyView(hotkey: hotkey)
                        }
                    }
                }
            }
            .searchable(text: $query, prompt: "Search...")
            .navigationTitle("XCode Hotkeys")
        }
    }
}

#Preview {
    HotkeysManagerView()
}
