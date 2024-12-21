//
//  ContentView.swift
//  MyCard
//
//  Created by Yuunan kin on 2024/12/21.
//

import SwiftUI

struct ContentView: View {
    @State var showToast = false
    var body: some View {
        ZStack {
            Color(UIColor(red: 0.20, green: 0.60, blue: 0.86, alpha: 1.00)).ignoresSafeArea()
            VStack {
                Image("Me")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))

                Text("Yuunan Kin")
                    .font(Font.custom("Pacifico-Regular", size: 40))
                    .foregroundColor(Color.white)
                Text("iOS Developer")
                    .font(.system(size: 24))
                    .foregroundColor(Color.white)
                Divider()
                    .background(Color.white)

                InfoView(
                    text: "+81 080 1234 5678",
                    imageName: "phone",
                    showToast: $showToast
                )
                .padding(.top)
                InfoView(text: "yuunan.kin@gmail.com", imageName: "envelope", showToast: $showToast)
            }
            .padding()
            if showToast {
                VStack {
                    Spacer()
                    Text("Copied to clipboard")
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.bottom, 50)
                }
                .transition(.opacity)
            }
        }
    }
}

#Preview {
    ContentView()
}
