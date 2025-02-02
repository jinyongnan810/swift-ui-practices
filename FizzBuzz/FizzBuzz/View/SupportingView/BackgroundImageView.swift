//
//  BackgroundImageView.swift
//  FizzBuzz
//
//  Created by Yuunan kin on 2025/02/02.
//

import SwiftUI

let images = [
    "https://code.kx.com/q/img/fizzbuzz.png",
    "https://images.pexels.com/photos/4068379/pexels-photo-4068379.jpeg?auto=compress&cs=tinysrgb&w=1600",
    "https://images.pexels.com/photos/6387827/pexels-photo-6387827.jpeg?auto=compress&cs=tinysrgb&w=1600",
]
struct BackgroundImageView: View {
    var image: String = images.randomElement() ?? images[0]
    var body: some View {
        AsyncImage(url: URL(string: image), transaction: .init(animation: .default)) {
            phase in
            switch phase {
            case let .success(image): image.resizable().scaledToFill()
                .blur(radius: 2)
                .opacity(0.4)
            default:
                Color.clear.opacity(0.3)
            }
        }.ignoresSafeArea()
    }
}

#Preview {
    BackgroundImageView()
}
