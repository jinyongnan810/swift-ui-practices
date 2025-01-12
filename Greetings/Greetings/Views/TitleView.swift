//
//  TitleView.swift
//  Greetings
//
//  Created by Yuunan kin on 2025/01/10.
//

import SwiftUI

struct TitleView: View {
    var isPortrait: Bool

    @State private var subtitle: LocalizedStringKey = "Explore SwiftUI"
    

    var body: some View {
        if isPortrait {
            HStack {
                GreetingsTextView(subtitle: $subtitle)
                Spacer()
                LogoView()
            }
        } else {
            VStack(alignment: .leading) {
                GreetingsTextView(subtitle: $subtitle)
                LogoView()
                Spacer()
            }.padding(.vertical)
        }

    }
}

#Preview {
    VStack {
        TitleView(isPortrait: false).padding()
        Spacer()
        TitleView(isPortrait: true).padding()
    }
}
