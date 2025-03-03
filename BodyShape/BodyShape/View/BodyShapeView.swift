//
//  BodyShapeView.swift
//  BodyShape
//
//  Created by Yuunan kin on 2025/03/03.
//

import SwiftUI

struct BodyShapeView: View {
    @State private var displayingSplashScreen: Bool = true
    @State private var blurRadius: CGFloat = 5

    var body: some View {
        ZStack {
            if displayingSplashScreen {
                SplashView()
                    .opacity(displayingSplashScreen ? 1 : 0)
                    .blur(radius: blurRadius)
                    .onTapGesture {
                        withAnimation(.easeIn(duration: 0.5)) {
                            blurRadius = 5
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            withAnimation(.easeIn(duration: 0.5)) {
                                displayingSplashScreen = false
                            }
                        }
                    }
            } else {
                DashBoardView()
            }
        }.onAppear {
            withAnimation(.easeIn(duration: 0.5)) {
                blurRadius = 0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation(.easeIn(duration: 0.5)) {
                    displayingSplashScreen = false
                }
            }
        }
    }
}

#Preview {
    BodyShapeView()
}
