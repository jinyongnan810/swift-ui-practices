//
//  NewHighScoreView.swift
//  AddingGame
//
//  Created by Yuunan kin on 2025/02/11.
//

import SwiftUI

struct NewHighScoreView: View {
    @Binding var isPresented: Bool
    @State private var name: String = ""
    @Environment(
        HighScoreViewModel.self
    ) var highScoreViewModel: HighScoreViewModel
    @Environment(GameViewModel.self) var gameViewModel: GameViewModel
    var body: some View {
        ZStack {
            BackgroundView(colorList: [.green, .cyan, .clear], opacity: 0.7)
            VStack {
                Spacer()
                Image("creature2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                Text("New High Score!")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom)
                Text("\(gameViewModel.score)")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.bottom)
                TextField("Your Name", text: $name)
                    .padding()
                    .multilineTextAlignment(.center)
                    .autocorrectionDisabled()
                    .font(.largeTitle)
                    .background(RoundedRectangle(cornerRadius: 12).fill(.white).shadow(radius: 3))
                    .padding()
                Button(action: {
                    highScoreViewModel
                        .addHighScore(name: name, score: gameViewModel.score)
                    gameViewModel.reset()
                    withAnimation {
                        isPresented = false
                    }
                }) {
                    Text("Save")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding()
                        .background(ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.blue)
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.white, lineWidth: 1)
                        }.shadow(radius: 3))

                }.disabled(name.isEmpty)
                Spacer()
            }
        }
    }
}

#Preview {
    NewHighScoreView(isPresented: .constant(true))
}
