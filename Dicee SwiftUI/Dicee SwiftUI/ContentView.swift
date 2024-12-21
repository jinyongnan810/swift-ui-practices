//
//  ContentView.swift
//  Dicee SwiftUI
//
//  Created by Yuunan kin on 2024/12/21.
//

import SwiftUI

struct ContentView: View {
    @State var diceNumber1: Int = 1
    @State var diceNumber2: Int = 2
    var body: some View {
        ZStack {
            Image("GreenBackground")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()
            VStack {
                Image("DiceeLogo").padding(.top)
                Spacer()
                HStack {
                    DiceView(diceNumber: $diceNumber1)
                    DiceView(diceNumber: $diceNumber2)
                }.padding(.horizontal)
                Spacer()
                Button(action: {
                    let rollCount = Int.random(in: 9 ... 15)
                    print(rollCount)
                    rollDiceWithDelay(rollCount: rollCount, currentCount: 0)
                }, label: {
                    Text("Roll")
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                        .padding(.all)
                }).frame(width: 200).background(Color.red).cornerRadius(12).padding()
            }
        }
    }

    private func rollDiceWithDelay(rollCount: Int, currentCount: Int) {
        guard currentCount < rollCount else { return }

        print("rolling...")
        rollDice()

        DispatchQueue.main.asyncAfter(
            deadline: .now() + (0.12 + 0.03 * Double(currentCount))
        ) {
            rollDiceWithDelay(
                rollCount: rollCount, currentCount: currentCount + 1
            )
        }
    }

    private func rollDice() {
        var random1 = Int.random(in: 1 ... 6)
        while random1 == diceNumber1 {
            random1 = Int.random(in: 1 ... 6)
        }
        diceNumber1 = random1

        var random2 = Int.random(in: 1 ... 6)
        while random2 == diceNumber2 {
            random2 = Int.random(in: 1 ... 6)
        }
        diceNumber2 = random2
    }
}

struct DiceView: View {
    @Binding var diceNumber: Int
    var body: some View {
        Image("dice\(diceNumber)")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 150)
            .padding()
    }
}

#Preview {
    ContentView()
}
