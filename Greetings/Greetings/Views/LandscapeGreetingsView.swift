//
//  LandscapeGreetingsView.swift
//  Greetings
//
//  Created by Yuunan kin on 2025/01/12.
//

import SwiftUI

struct LandscapeGreetingsView: View {
    var body: some View {
        ZStack {
            BackgroundView()

            HStack{
                TitleView(isPortrait: false)
                Spacer()
                MessagesView()
            }.padding()
        }
    }
}

#Preview {
    LandscapeGreetingsView()
}
