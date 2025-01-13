//
//  MainView.swift
//  Greetings
//
//  Created by Yuunan kin on 2025/01/12.
//

import SwiftUI

struct MainView: View {
    @Binding var language: String?

    var body: some View {
        NavigationStack {
            GreetingsView()
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        LanguageOptionView(language: $language)
                    }
                }
        }
    }
}

#Preview {
    MainView(language: .constant("en"))
}
