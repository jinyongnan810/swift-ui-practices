//
//  HighScoreTitleView.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/11.
//

import SwiftUI

struct HighScoreTitleView: View {
    let image: String
    let text: LocalizedStringKey
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .frame(width: 50, height: 50)
            Text(text)
                .font(.headline)
                .foregroundStyle(.white)
        }.frame(maxWidth: .infinity)
    }
}
