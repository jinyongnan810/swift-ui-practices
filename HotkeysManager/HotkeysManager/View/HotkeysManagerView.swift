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

    private var hotKeysToDisplay: [HotkeyCategoryModel] {
        viewModel.filteredWith(searchTerm: query)
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(hotKeysToDisplay) { category in
                    if !category.hotkeys.isEmpty {
                        Section {
                            ForEach(category.hotkeys) { hotkey in
                                HotkeyView(hotkey: hotkey)
                            }
                        } header: {
                            Text(category.name)
                                .font(.headline)
                        }
                    }

                }
            }
            .listStyle(Theme.listStyle)
            .searchable(text: $query, prompt: "Search...")
            .navigationTitle("XCode Hotkeys")
        }.frame(minWidth: Theme.minWidth, minHeight: Theme.minHeight)
    }
}

#Preview {
    HotkeysManagerView()
}
