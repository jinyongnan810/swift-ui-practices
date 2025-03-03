//
//  WelcomeView.swift
//  BodyShape
//
//  Created by Yuunan kin on 2025/03/03.
//

import SwiftUI

struct WelcomeView: View {
    var name: Text {
        Text("Emily")
            .fontWeight(.bold)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Hi. \(name)")
                .font(.largeTitle)
            Text("Your boards looks great!")
                .font(.title2)
                .frame(width: screenWidth / 2, alignment: .leading)
        }.frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    WelcomeView()
}
