//
//  TitleView.swift
//  Greetings
//
//  Created by Yuunan kin on 2025/01/10.
//

import SwiftUI
import TipKit

struct TitleView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass

    var isPortraitPhone: Bool {
        horizontalSizeClass == .compact && verticalSizeClass == .regular
    }

    var isIPad: Bool {
        horizontalSizeClass == .regular && verticalSizeClass == .regular
    }

    @State private var subtitle: LocalizedStringKey = "Explore SwiftUI"

    private var greetingsTip = GreetingsTip()

    var body: some View {
        if isPortraitPhone || isIPad {
            HStack {
                GreetingsTextView(subtitle: $subtitle)
                    .popoverTip(greetingsTip)
                Spacer()
                LogoView()
            }
        } else {
            VStack(alignment: .leading) {
                GreetingsTextView(subtitle: $subtitle)
                    .popoverTip(greetingsTip)
                LogoView()
                Spacer()
            }.padding(.vertical)
        }
    }
}

#Preview {
    VStack {
        TitleView().padding()
        Spacer()
        TitleView().padding()
    }
}
