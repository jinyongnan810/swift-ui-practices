//
//  SplashScreenView.swift
//  Alarm
//
//  Created by Yuunan kin on 2025/02/14.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var active: Bool = false
    var body: some View {
        if active {
            AlarmView()
        } else {
            SplashView(active: $active)
        }
    }
}

struct SplashView: View {
    @Binding var active: Bool
    @State private var opacity: Double = 0.3
    @State private var blur: CGFloat = 5
    @State private var fontSize: Font = .subheadline
    var body: some View {
        ZStack {
            FourCircleBackgroundView(color1: .myBlue, color2: .clear)
            VStack {
                Text("Your Alarm App")
                    .font(fontSize)
                Spacer()
                Image("welcome")
                    .resizable()
                    .scaledToFit()
                    .padding()
                Spacer()
            }
        }
        .opacity(opacity)
        .blur(radius: blur)
        .onAppear {
            withAnimation(.easeIn(duration: 0.7)) {
                opacity = 1
                fontSize = .largeTitle
                blur = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeIn) {
                    active = true
                }
            }
        }
        .onTapGesture {
            withAnimation(.easeIn) {
                active = true
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
