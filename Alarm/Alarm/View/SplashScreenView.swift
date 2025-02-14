//
//  SplashScreenView.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/14.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var active: Bool = false
    @State private var opacity: Double = 0.3
    @State private var blur: CGFloat = 5
    @State private var fontSize: CGFloat = 12
    var body: some View {
        if active {
            AlarmView()
        } else {
            ZStack {
                FourCircleBackgroundView(color1: .myBlue, color2: .clear)
                VStack {
                    Text("Your Alarm")
                        .font(.system(size: fontSize))
                }
            }.opacity(opacity)
                .blur(radius: blur)
                .onAppear {
                    withAnimation(.easeIn(duration: 1)) {
                        opacity = 1
                        fontSize = 36
                        blur = 0
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation(.easeIn) {
                            active = true
                        }
                    }
                }
        }
    }
}

#Preview {
    SplashScreenView()
}
