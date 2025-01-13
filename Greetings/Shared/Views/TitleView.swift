//
//  TitleView.swift
//  Greetings
//
//  Created by Yuunan kin on 2025/01/10.
//

import SwiftUI
import TipKit

struct TitleView: View {
    var useHorizontalLayout: Bool

    @State private var subtitle: LocalizedStringKey = "Explore SwiftUI"

    private var greetingsTip = GreetingsTip()

    public init(useHorizontalLayout: Bool) {
        self.useHorizontalLayout = useHorizontalLayout
    }

    var body: some View {
        if useHorizontalLayout {
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
        TitleView(useHorizontalLayout: true).padding()
        Spacer()
        TitleView(useHorizontalLayout: false).padding()
    }
}
