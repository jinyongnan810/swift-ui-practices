//
//  AboutView.swift
//  FizzBuzz
//
//  Created by Yuunan kin on 2025/02/02.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        GeometryReader { geo in
            ZStack {
                BackgroundImageView().ignoresSafeArea()
                    .frame(width: geo.size.width, height: geo.size.height)
                Text("""
                Fizz buzz is a group word game for children to teach them about division.[1] Players take turns to count incrementally, replacing any number divisible by three with the word "fizz", and any number divisible by five with the word "buzz", and any number divisible by both three and five with the word "fizzbuzz".

                Players generally sit in a circle. The player designated to go first says the number "one", and the players then count upwards in turn. However, any number divisible by three is replaced by the word fizz and any number divisible by five is replaced by the word buzz. Numbers divisible by both three and five (i.e. divisible by fifteen) become fizz buzz. A player who hesitates or makes a mistake is eliminated.

                For example, a typical round of fizz buzz would start as follows:
                1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, Fizz Buzz, 16, 17, Fizz, 19, Buzz, Fizz, 22, 23, Fizz, Buzz, 26, Fizz, 28, 29, Fizz Buzz, 31, 32, Fizz, 34, Buzz, Fizz, ...
                """)
                .font(.title)
                .multilineTextAlignment(.leading)
                .minimumScaleFactor(0.1)
                .padding()
            }
        }
    }
}

#Preview {
    AboutView()
}
