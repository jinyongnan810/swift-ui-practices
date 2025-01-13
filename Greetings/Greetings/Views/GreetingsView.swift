//
//  GreetingsView.swift
//  Greetings
//
//  Created by Yuunan kin on 2025/01/09.
//

import SwiftUI

struct GreetingsView: View {
    var body: some View {
        ZStack {
            BackgroundView()

            VStack(alignment: .leading) {
                TitleView()
                Spacer()
                MessagesView()
                Spacer()
                Spacer()
            }.padding()
        }
    }
}

#Preview {
    GreetingsView()
}
