//
//  SplashView.swift
//  BodyShape
//
//  Created by Yuunan kin on 2025/03/03.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                HStack {
                    Image(systemName: "line.3.horizontal")
                        .imageScale(.large)
                        .fontWeight(.bold)

                    Spacer()
                }.padding()
                Spacer()
                VStack(alignment: .leading) {
                    Text("Discover How To Shape Your Body")
                        .font(.system(size: 50))
                        .fontWeight(.bold)
                    HStack {
                        Image(systemName: "arrow.forward")
                            .foregroundStyle(.white)
                            .padding(7)
                            .background(Circle().fill(.black))
                            .padding(16)
                            .background(Circle().fill(.lightGreen))
                        Spacer()
                    }
                }
            }.padding()
        }
    }
}

struct BackgroundView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Circle().fill(.lightPurple)
                .frame(width: screenWidth * 2)
                .offset(y: -screenHeight * 0.4)
            Image(bikeImage)
                .resizable()
                .scaledToFit()
                .frame(width: screenWidth * 0.7)
        }.padding()
            .frame(maxWidth: screenWidth)
    }
}

#Preview {
    SplashView()
}
