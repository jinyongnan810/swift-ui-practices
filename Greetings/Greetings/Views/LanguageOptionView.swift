//
//  LanguageOptionView.swift
//  Greetings
//
//  Created by Yuunan kin on 2025/01/13.
//

import SwiftUI

struct LanguageOptionView: View {
    @Binding var language: String?
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
//        Image(systemName: "gearshape.fill")
//            .contextMenu {
//                Button("English") {
//                    language = "en"
//                }
//                Button("日本語") {
//                    language = "ja"
//                }
//            }

        Menu {
            Button("English") {
                language = "en"
            }
            Button("日本語") {
                language = "ja"
            }
        } label: {
            Image(systemName: "gearshape.fill")
                .foregroundColor(colorScheme == .dark ? .white : .black)
        }

    }
}

#Preview {
    LanguageOptionView(language: .constant("en"))
}
